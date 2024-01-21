import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uber/common/widget/assetsGen.dart';
import 'package:uber/common/widget/elevatedButtonCommon.dart';
import 'package:uber/common/widget/orDiveder.dart';
import 'package:uber/constant/utils/colors.dart';
import 'package:uber/constant/utils/textStyles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mobileNumberController = TextEditingController();
  String selectedCountryCode = '+62';
  bool loginButtonPressed = false;
  List loginButtonData = [
    [const AssetGen().google.svg(height: 3.h), 'Google'],
    [const AssetGen().apple.svg(height: 3.h), 'Apple'],
    [const AssetGen().facebook.svg(height: 3.h), 'Facebook'],
    [const AssetGen().mail.svg(height: 3.h), 'Mail'],
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 2.h),
        children: [
          SizedBox(
            height: 1.h,
          ),
          Text(
            ' Enter Your Mobile Number',
            style: AppTextStyles.body18,
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    onSelect: (value) {
                      setState(() {
                        selectedCountryCode = '+${value.phoneCode}';
                      });
                    },
                  );
                },
                child: Container(
                  height: 5.h,
                  width: 15.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.sp),
                    color: grey,
                    border: Border.all(color: grey),
                  ),
                  child: Text(selectedCountryCode),
                ),
              ),
              SizedBox(
                width: 70.w,
                child: TextFormField(
                  controller: mobileNumberController,
                  cursorColor: black,
                  style: AppTextStyles.textFieldHintTextStyle,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 2.w),
                    hintText: 'Mobile Number',
                    hintStyle: AppTextStyles.textFieldHintTextStyle,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.sp),
                      borderSide: BorderSide(
                        color: grey,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.sp),
                      borderSide: BorderSide(
                        color: grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.sp),
                      borderSide: BorderSide(
                        color: grey,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 2.h),
          ElevatedButtonCommon(
            onPressed: () {},
            backgroundColor: black,
            width: 94.w,
            height: 6.h,
            child: loginButtonPressed == true
                ? const CircularProgressIndicator()
                : Text('Continue',
                    style: AppTextStyles.small12Bold.copyWith(color: white)),
          ),
          SizedBox(height: 2.h),
          const OrDivider(),
          SizedBox(height: 2.h),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: loginButtonData.length,
            itemBuilder: (context, index) {
              return Container(
                height: 6.h,
                width: 94.w,
                margin: EdgeInsets.symmetric(vertical: 0.5.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.sp),
                    color: greyShade3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loginButtonData[index][0],
                    SizedBox(
                      width: 2.w,
                    ),
                    Text('Continue with ${loginButtonData[index][1]}')
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 2.h),
          const OrDivider(),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search,
                color: black,
              ),
              Text(
                'Find My Account',
                style: AppTextStyles.body14,
              )
            ],
          ),
          SizedBox(height: 3.h),
          Text(
            'By Procceding, you consent to get calls, WhatsApp SMS message, including by autometed means, from uber and its affiliates to the number provided',
            style: AppTextStyles.small10.copyWith(color: grey),
          ),
          SizedBox(height: 15.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'This site is protected by reCAPTCAH and the Google ',
                  style: AppTextStyles.small10.copyWith(color: grey),
                ),
                TextSpan(
                  text: 'Privacy Policy',
                  style: AppTextStyles.small10
                      .copyWith(decoration: TextDecoration.underline),
                ),
                TextSpan(
                  text: ' and ',
                  style: AppTextStyles.small10.copyWith(color: grey),
                ),
                TextSpan(
                  text: 'Term of service ',
                  style: AppTextStyles.small10
                      .copyWith(decoration: TextDecoration.underline),
                ),
                TextSpan(
                  text: 'apply',
                  style: AppTextStyles.small10.copyWith(color: grey),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
