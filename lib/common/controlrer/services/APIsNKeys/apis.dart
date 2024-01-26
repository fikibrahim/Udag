import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/common/controlrer/services/APIsNKeys/keys.dart';

class APIs{
  static geoCodingAPI(LatLng position)=> 'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapsPlatformcredemtial';
}