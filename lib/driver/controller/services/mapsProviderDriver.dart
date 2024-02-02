import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsProviderDriver extends ChangeNotifier {
  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(-6.142232001579447, 106.85817085404454), zoom: 14.4746);
  final Completer<GoogleMapController> mapsControllerDriver = Completer();
  LatLng? currentLocation;

  updateCurrentLocation(LatLng newLocation) {
    currentLocation = newLocation;
    notifyListeners();
  }
}
