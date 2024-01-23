// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MobileAuthProvider extends ChangeNotifier {
  String? mobileNumber;
  String? verificationCode;

  // MobileAuthProvider({
  //   this.mobileNumber,
  //   this.verificationCode,
  // });

  updateMobileNumber(String number) {
    mobileNumber = number;
    notifyListeners();
  }

  updateverificationCode(String code) {
    verificationCode = code;
    notifyListeners();
  }
}
