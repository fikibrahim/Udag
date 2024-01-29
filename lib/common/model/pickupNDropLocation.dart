import 'dart:convert';

class PickupNDropLocationModel {
  String? name;
  String? description;
  String? placeID;
  String? latitude;
  String? longitude;
  PickupNDropLocationModel({
    this.name,
    this.description,
    this.placeID,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'placeID': placeID,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory PickupNDropLocationModel.fromMap(Map<String, dynamic> map) {
    return PickupNDropLocationModel(
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      placeID: map['placeID'] != null ? map['placeID'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as String : null,
      longitude: map['longitude'] != null ? map['longitude'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PickupNDropLocationModel.fromJson(String source) =>
      PickupNDropLocationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
