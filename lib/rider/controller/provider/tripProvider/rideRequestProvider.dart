import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/common/model/directionModel.dart';
import 'package:uber/constant/utils/colors.dart';

class RideRequestProvider extends ChangeNotifier {
  Set<Marker> riderMarker = Set<Marker>();
  Set<Polyline> polylineSet = {};
  Polyline? polyline;
  List<LatLng> polylineCoordinatesList = [];
  DirectionModel? directionDetails;
  BitmapDescriptor? carIconForMap;
  BitmapDescriptor? destinationIconForMap;
  BitmapDescriptor? pickupIconForMap;

  updateDirection(DirectionModel newDirection) {
    directionDetails = newDirection;
    notifyListeners();
  }

  updatePolylineAndUpdatePolylineField() {
    PolylinePoints polylinePoints = PolylinePoints();
    polylineCoordinatesList.clear();
    polylineSet.clear();
    List<PointLatLng> data =
        polylinePoints.decodePolyline(directionDetails!.polylinePoints);

    if (data.isNotEmpty) {
      for (var latLangPoints in data) {
        polylineCoordinatesList
            .add(LatLng(latLangPoints.latitude, latLangPoints.longitude));
      }
    }

    polyline = Polyline(
        polylineId: const PolylineId('TripPolyLine'),
        color: black,
        points: polylineCoordinatesList,
        jointType: JointType.round,
        width: 3,
        startCap: Cap.roundCap,
        geodesic: true);

    polylineSet.add(polyline!);
    notifyListeners();
  }

  createIcons() {
    if (pickupIconForMap == null) {
      ImageConfiguration imageConfiguration = createLocalImageConfiguration(
          context as BuildContext,
          size: Size(2, 2));
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, 'assets/images/icons/pickupPng.png')
          .then((icon) {
        pickupIconForMap = icon;
        notifyListeners();
      });
      if (destinationIconForMap == null) {
        ImageConfiguration imageConfiguration = createLocalImageConfiguration(context as BuildContext,size: Size(2, 2));
        BitmapDescriptor.fromAssetImage(imageConfiguration, 'assets/images/icons/dropPng.png').then((icon) {
          destinationIconForMap = icon;
          notifyListeners();
        });
        
      }

      if (carIconForMap == null) {
        ImageConfiguration imageConfiguration = createLocalImageConfiguration(context as BuildContext,size: Size(2, 2));
        BitmapDescriptor.fromAssetImage(imageConfiguration, 'assets/images/vehicle/mapCar.png').then((icon) {
          destinationIconForMap = icon;
          notifyListeners();
        });
        
      }
    }
  }
}
