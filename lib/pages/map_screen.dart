import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracker_moche/components/buttons.dart';
import 'package:tracker_moche/controllers/location_controller.dart';

class MapScreen extends StatefulWidget {
  final bool isConductor;
  const MapScreen({super.key, required this.isConductor});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const CameraPosition _defaulLocation = CameraPosition(
    target: LatLng(-8.17061667, -79.00943),
    zoom: 16,
  );

  late LocationController _locationController;

  @override
  void initState() {
    super.initState();
    _locationController = Get.put(LocationController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _defaulLocation,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: widget.isConductor
          ? GetBuilder<LocationController>(
              init: LocationController(),
              builder: (controller) {
                return CompartirUbiacionBoton(
                  isSharing: controller.isSharing,
                  onPressed: () {
                    controller.shareLocation();
                    print(controller.isSharing);
                  },
                );
              },
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
