import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber/common/controlrer/services/APIsNKeys/apis.dart';
import 'package:http/http.dart' as http;
import 'package:uber/common/model/directionModel.dart';
import 'package:uber/rider/controller/provider/tripProvider/rideRequestProvider.dart';

class DirectionServices {
  static Future getDirectionDetails(
      LatLng pickUpLocation, LatLng dropLocation, BuildContext context) async {
    final api = Uri.parse(APIs.directionAPI(pickUpLocation, dropLocation));

    try {
      var response = await http
          .get(api, headers: {'Content-Type': 'application/json'}).timeout(
              const Duration(seconds: 60), onTimeout: () {
        throw TimeoutException('Connection Timed Out');
      }).onError((error, stackTrace) {
        throw TimeoutException('Connection Timed Out');
      }).onError((error, stackTrace) {
        throw Exception(error);
      });

      if (response.statusCode == 200) {
        var decodeResponse = jsonDecode(response.body);
        print('ini : ${decodeResponse.toString()}');

        DirectionModel directionModel = DirectionModel(
            distanceInKM: decodeResponse['routes'][0]['legs'][0]['distance']
                ['text'],
            distanceInMeter: decodeResponse['routes'][0]['legs'][0]['distance']
                ['value'],
            durationInHour: decodeResponse['routes'][0]['legs'][0]['duration']
                ['text'],
            duration: decodeResponse['routes'][0]['legs'][0]['duration']
                ['value'],
            polylinePoints: decodeResponse['routes'][0]['overview_polyline']
                ['points']);
                print(directionModel.toMap().toString());
                context.read<RideRequestProvider>().updateDirection(directionModel);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
