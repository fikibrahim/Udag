import 'package:flutter/material.dart';
import 'package:uber/common/model/pickupNDropLocation.dart';
import 'package:uber/common/model/searchAddressModel.dart';

class LocationProvider extends ChangeNotifier {
  List<SearchAddressModel> searchAddress = [];
  PickupNDropLocationModel? dropLocation;
  PickupNDropLocationModel? pickUpLocation;

  updateSearchAddress(List<SearchAddressModel> newAddressList) {
    searchAddress = newAddressList;
    notifyListeners();
  }

  emptySearchAddressList() {
    searchAddress = [];
    notifyListeners();
  }

  updateDropLocation(PickupNDropLocationModel newAddress) {
    dropLocation = newAddress;
    notifyListeners();
  }
  
  updatePickupLocation(PickupNDropLocationModel newAddress) {
    pickUpLocation = newAddress;
    notifyListeners();
  }
}
