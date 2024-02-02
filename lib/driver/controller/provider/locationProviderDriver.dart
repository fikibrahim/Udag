import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProviderDriver extends ChangeNotifier {
  Position? position;

  updateDriverPosition(Position newPosition) {
    position = newPosition;
    notifyListeners();
  }
}
