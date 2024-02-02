import 'package:flutter/material.dart';
import 'package:uber/common/controlrer/services/profileDataCRUDServices.dart';
import 'package:uber/common/model/profileDataModel.dart';
import 'package:uber/constant/constants.dart';

class ProfileDataProvider extends ChangeNotifier {
  ProfileDataModel? profileData;

  getProfileData() async {
    profileData =
        await ProfileDataCRUDServices.getProfileDataFromRealTimeDatabase(
            auth.currentUser!.phoneNumber!);
            print(profileData!.toMap().toString());
    notifyListeners();
  }
}
