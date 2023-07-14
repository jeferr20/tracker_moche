import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  Position? _currentPosition;
  Position? get currentPosition => _currentPosition;
  bool _isSharing = false;
  bool get isSharing => _isSharing;

  @override
  void onInit() {
    super.onInit();
    initializeFirebase();
    fetchLocation();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  Future<void> fetchLocation() async {
    try {
      var geolocationStatus = await Geolocator.checkPermission();
      if (geolocationStatus == LocationPermission.denied) {
        geolocationStatus = await Geolocator.requestPermission();
      }

      if (geolocationStatus == LocationPermission.denied ||
          geolocationStatus == LocationPermission.deniedForever) {
        // Manejar el permiso denegado
        return;
      }

      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      _currentPosition = position;
      print(_currentPosition);
      if (_isSharing) {
        // Guardar la ubicación en Cloud Firestore solo si se está compartiendo
        await saveLocationToFirestore(position.latitude, position.longitude);
      }

      update(); // Actualizar el estado del controlador
    } catch (e) {
      // Manejar cualquier error que pueda ocurrir
    }
  }

  void toggleSharing() {
    _isSharing = !_isSharing;
    if (_isSharing) {
      // Comenzar a compartir la ubicación del usuario
      fetchLocation();
    } else {
      // Dejar de compartir la ubicación del usuario
      // Quitar la ubicación del controlador
      _currentPosition = null;
      update(); // Actualizar el estado del controlador
    }
  }

  Future<void> saveLocationToFirestore(
      double latitude, double longitude) async {
    try {
      final collectionRef =
          FirebaseFirestore.instance.collection('ubicacionUsuarios');
      await collectionRef.add({
        'latitude': latitude,
        'longitude': longitude,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      // Manejar cualquier error al guardar la ubicación en Firestore
    }
  }
}
