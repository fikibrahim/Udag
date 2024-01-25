// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber/common/controlrer/provider/authProvider.dart';
import 'package:uber/common/controlrer/services/profileDataCRUDServices.dart';
import 'package:uber/common/view/authScreren/loginScreen.dart';
import 'package:uber/common/view/authScreren/otpScreen.dart';
import 'package:uber/common/view/driverHomeScreen.dart';
import 'package:uber/common/view/registrationScreen/registrationScreen.dart';
import 'package:uber/constant/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uber/rider/view/bottomNavbar/bottomNavbarRider.dart';
import 'package:uber/rider/view/homeScreen/riderHomeScreen.dart';

class MobileAuthServices {

  static receiveOTP(
      {required BuildContext context, required String mobileNumber}) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: mobileNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          // log(credential.toString() as num);
        },
        verificationFailed: (FirebaseAuthException exception) {
          // log(exception.toString() as num);
        },
        codeSent: (String verificationCode, int? resendToken) {
          context
              .read<MobileAuthProvider>()
              .updateverificationCode(verificationCode);
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: const OTPScreen()));
        },
        codeAutoRetrievalTimeout: (String verificationID) {},
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  static verfyOTP({required BuildContext context, required String otp}) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: context.read<MobileAuthProvider>().verificationCode!,
          smsCode: otp);
      await auth.signInWithCredential(credential);
      Navigator.push(
          context,
          PageTransition(
              child: BottomNavbarRider(),
              type: PageTransitionType.rightToLeft));
    } catch (e) {
      throw Exception(e);
    }
  }

  static bool checkAuthentication() {
    User? user = auth.currentUser;
    if (user != null) {
      return true;
    }
    return false;
  }

  static checkAuthenticationAndNavigate({required BuildContext context}) {
    bool userIsAuthenticated = checkAuthentication();
    userIsAuthenticated
        ? checkUser(context)
        : Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const LoginScreen(),
                type: PageTransitionType.rightToLeft),
            (route) => false,
          );
  }

  static checkUser(BuildContext context) async {
    bool userIsRegistered =
        await ProfileDataCRUDServices.checkForRegisterUser(context);

    if (userIsRegistered == true) {
      bool userIsDriver = await ProfileDataCRUDServices.userIsDriver(context);
      if (userIsDriver == true) {
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const RiderHomeScreen(),
                type: PageTransitionType.rightToLeft),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const BottomNavbarRider(),
                type: PageTransitionType.rightToLeft),
            (route) => false);
      }
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
              child: const RegistrationScreen(),
              type: PageTransitionType.rightToLeft),
          (route) => false);
    }
  }
}
