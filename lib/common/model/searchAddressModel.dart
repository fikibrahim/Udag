import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SearchAddressModel {
  String mainName;
  String secondryName;
  String placeID;

  SearchAddressModel({
    required this.mainName,
    required this.secondryName,
    required this.placeID,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mainName': mainName,
      'secondryName': secondryName,
      'placeID': placeID,
    };
  }

  factory SearchAddressModel.fromMap(Map<String, dynamic> map) {
    return SearchAddressModel(
      mainName: map['mainName'] as String,
      secondryName: map['secondryName'] as String,
      placeID: map['placeID'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchAddressModel.fromJson(String source) => SearchAddressModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
