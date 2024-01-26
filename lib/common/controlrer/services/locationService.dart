import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/common/controlrer/services/APIsNKeys/apis.dart';
import 'package:http/http.dart' as http;
import 'package:uber/common/controlrer/services/toastServices.dart';
import 'package:uber/common/model/pickupNDropLocation.dart';

class LoccationServices {
  static getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      getCurrentLocation();
    }
    Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );
    LatLng currentLocation = LatLng(
      currentPosition.latitude,
      currentPosition.longitude,
    );
    return currentLocation;
  }

  static Future getAddressFromLatLng(
      {required LatLng position, required BuildContext context}) async {
    final api = Uri.parse(APIs.geoCodingAPI(position));
    try {
      var response = await http
          .get(api, headers: {'Content-type': 'application/json'}).timeout(
              const Duration(seconds: 60), onTimeout: () {
        ToastService.sendScaffoldAlert(
          msg: 'Oops!',
          toastStatus: 'ERROR',
          context: context,
        );
        throw TimeoutException('Connection Timed Out');
      });
      if (response.statusCode == 200) {
        var decodeResponse = jsonDecode(response.body);
        PickupNDropLocationModel model = PickupNDropLocationModel(
          name: decodeResponse['results'][0]['formatted_address'],
          placeID: decodeResponse['results'][0]['place_id'],
          latitude: position.latitude.toString(),
          longitude: position.longitude.toString(),
        );
        return model;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
