import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController {
  late bool isSharing;
  late StreamSubscription<Position> positionStreamSubscription;

  @override
  void onInit() {
    super.onInit();
    isSharing = false;
  }

  Future<void> toggleSharing() async {
    isSharing = !isSharing;
    update();
  }

  Future<void> saveLocationToFirestore(
      Position position, String userEmail) async {
    try {
      await FirebaseFirestore.instance
          .collection('ubicaciones')
          .doc(userEmail)
          .set({
        'latitud': position.latitude,
        'longitud': position.longitude,
      });
    } catch (error) {
      print('Error al guardar la ubicación en Firestore: $error');
    }
  }

  Future<void> shareLocation() async {
    if (isSharing) return;
    // Obtener la ubicación actual
    // Obtener el correo electrónico del usuario actual
    String? userEmail = FirebaseAuth.instance.currentUser?.email;

    if (userEmail == null) return; // Verificar si el usuario está autenticado

    // Suscribirse a las actualizaciones de posición
    positionStreamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      // Guardar la ubicación en Firestore con el nombre del documento como el correo electrónico
      saveLocationToFirestore(position, userEmail);
    });

    toggleSharing();
  }
}
