import 'package:flutter/material.dart';
import 'package:uber/common/controlrer/provider/mobileAuthServices.dart';
import 'package:uber/constant/utils/colors.dart';

class SignInLogic extends StatefulWidget {
  const SignInLogic({super.key});

  @override
  State<SignInLogic> createState() => _SignInLogicState();
}

class _SignInLogicState extends State<SignInLogic> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      MobileAuthServices.checkAuthenticationAndNavigate(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: const Center(
        child: Image(image: AssetImage('assets/images/uberLogo/uber.png')),
      ),
    );
  }
}
