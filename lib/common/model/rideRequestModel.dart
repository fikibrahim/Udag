// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:uber/common/model/pickupNDropLocation.dart';
import 'package:uber/common/model/profileDataModel.dart';

class RideRequestModel {
  DateTime rideCreateTime;
  ProfileDataModel riderProfile;
  ProfileDataModel? driverProfile;
  PickupNDropLocationModel pickUpLocation;
  PickupNDropLocationModel dropLocation;
  String fare;
  String caryType;
  String rideStatus;
  String OTP;

  RideRequestModel({
    required this.rideCreateTime,
    required this.riderProfile,
    this.driverProfile,
    required this.pickUpLocation,
    required this.dropLocation,
    required this.fare,
    required this.caryType,
    required this.rideStatus,
    required this.OTP,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rideCreateTime': rideCreateTime.millisecondsSinceEpoch,
      'riderProfile': riderProfile.toMap(),
      'driverProfile': driverProfile?.toMap(),
      'pickUpLocation': pickUpLocation.toMap(),
      'dropLocation': dropLocation.toMap(),
      'fare': fare,
      'caryType': caryType,
      'rideStatus': rideStatus,
      'OTP': OTP,
    };
  }

  factory RideRequestModel.fromMap(Map<String, dynamic> map) {
    return RideRequestModel(
      rideCreateTime: DateTime.fromMillisecondsSinceEpoch(map['rideCreateTime'] as int),
      riderProfile: ProfileDataModel.fromMap(map['riderProfile'] as Map<String,dynamic>),
      driverProfile: map['driverProfile'] != null ? ProfileDataModel.fromMap(map['driverProfile'] as Map<String,dynamic>) : null,
      pickUpLocation: PickupNDropLocationModel.fromMap(map['pickUpLocation'] as Map<String,dynamic>),
      dropLocation: PickupNDropLocationModel.fromMap(map['dropLocation'] as Map<String,dynamic>),
      fare: map['fare'] as String,
      caryType: map['caryType'] as String,
      rideStatus: map['rideStatus'] as String,
      OTP: map['OTP'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RideRequestModel.fromJson(String source) => RideRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
