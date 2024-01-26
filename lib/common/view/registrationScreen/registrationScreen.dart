// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:sizer/sizer.dart';
import 'package:uber/common/controlrer/services/imageServices.dart';
import 'package:uber/common/controlrer/services/profileDataCRUDServices.dart';
import 'package:uber/common/controlrer/services/toastServices.dart';
import 'package:uber/common/model/profileDataModel.dart';
import 'package:uber/common/widget/elevatedButtonCommon.dart';
import 'package:uber/constant/constants.dart';
import 'package:uber/constant/utils/colors.dart';
import 'package:uber/constant/utils/textStyles.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController vehicleModelNameColtroller = TextEditingController();
  TextEditingController vehicleBrandNameController = TextEditingController();
  TextEditingController vehicleRegistrationNumberController =
      TextEditingController();
  TextEditingController drivingLicenseNumberController =
      TextEditingController();

  String selectedVehicleType = 'Select Vhicle Type';
  List<String> VhicleTypes = [
    'Select Vhicle Type',
    'Mini',
    'Sedan',
    'SUV',
    'Biek',
  ];

  String userType = 'Customer';
  File? profilePic;
  bool registerButtonPressed = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mobileController.text = auth.currentUser!.phoneNumber!;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    vehicleBrandNameController.dispose();
    vehicleModelNameColtroller.dispose();
    vehicleRegistrationNumberController.dispose();
    drivingLicenseNumberController.dispose();
  }

  registerDriver() async {
    if (profilePic == null) {
      ToastService.sendScaffoldAlert(
        msg: 'Select a Profile Pic',
        toastStatus: 'WARNING',
        context: context,
      );
    } else if (nameController.text.isEmpty) {
      ToastService.sendScaffoldAlert(
        msg: 'Enter your Name',
        toastStatus: 'WARNING',
        context: context,
      );
    } else if (mobileController.text.isEmpty) {
      ToastService.sendScaffoldAlert(
        msg: 'Enter your Mobile number',
        toastStatus: 'WARNING',
        context: context,
      );
    } else if (emailController.text.isEmpty) {
      ToastService.sendScaffoldAlert(
        msg: 'Enter your Email',
        toastStatus: 'WARNING',
        context: context,
      );
    } else if (vehicleBrandNameController.text.isEmpty) {
      ToastService.sendScaffoldAlert(
        msg: 'Enter the Vehicle Brand Name',
        toastStatus: 'WARNING',
        context: context,
      );
    } else if (vehicleModelNameColtroller.text.isEmpty) {
      ToastService.sendScaffoldAlert(
        msg: 'Enter the vehicle model name',
        toastStatus: 'WARNING',
        context: context,
      );
    } else if (selectedVehicleType == 'Select Vehicle Type') {
      ToastService.sendScaffoldAlert(
        msg: 'Select a vehicle type',
        toastStatus: 'WARNING',
        context: context,
      );
    } else if (vehicleRegistrationNumberController.text.isEmpty) {
      ToastService.sendScaffoldAlert(
        msg: 'Enter vehicle registration number',
        toastStatus: 'WARNING',
        context: context,
      );
    } else if (drivingLicenseNumberController.text.isEmpty) {
      ToastService.sendScaffoldAlert(
        msg: 'Enter your Driving license number',
        toastStatus: 'WARNING',
        context: context,
      );
    } else {
      String profilePicURL = await ImageServices.uploadImageToFirebaseStorage(
          image: File(profilePic!.path), context: context);

      ProfileDataModel profileData = ProfileDataModel(
          // profilePicUrl: profilePicURL,
          // name: nameController.text.trim(),
          // mobileNumber: auth.currentUser!.phoneNumber!,
          // email: emailController.text.trim(),
          // userType: 'PARTNER',
          // vehicleBrandName: vehicleBrandNameController.text.trim(),
          // vehicleModel: vehicleModelNameColtroller.text.trim(),
          // vehicleType: selectedVehicleType,
          // vehicleRegistrationNumber:
          //     vehicleRegistrationNumberController.text.trim(),
          // drivingLicenseNumber: drivingLicenseNumberController.text.trim(),
          // registeredDateTime: DateTime.now(),
          );
      await ProfileDataCRUDServices.registerUserToDatabase(
          profileData: profileData, context: context);
    }
  }

  registerCustomer() async {
    if (profilePic == null) {
      ToastService.sendScaffoldAlert(
        msg: 'Select a Profile Pic',
        toastStatus: 'WARNING',
        context: context,
      );
    } else if (nameController.text.isEmpty) {
      ToastService.sendScaffoldAlert(
        msg: 'Enter your Name',
        toastStatus: 'WARNING',
        context: context,
      );
    } else if (mobileController.text.isEmpty) {
      ToastService.sendScaffoldAlert(
        msg: 'Enter your Mobile number',
        toastStatus: 'WARNING',
        context: context,
      );
    } else if (emailController.text.isEmpty) {
      ToastService.sendScaffoldAlert(
        msg: 'Enter your Email',
        toastStatus: 'WARNING',
        context: context,
      );
    } else {
      String profilePicURL = await ImageServices.uploadImageToFirebaseStorage(
          image: File(profilePic!.path), context: context);
      ProfileDataModel profileData = ProfileDataModel(
        profilePicUrl: profilePicURL,
        name: nameController.text.trim(),
        mobileNumber: auth.currentUser!.phoneNumber!,
        email: emailController.text.trim(),
        userType: 'CUSTOMER',
        registeredDateTime: DateTime.now(),
      );
      await ProfileDataCRUDServices.registerUserToDatabase(
          profileData: profileData, context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        children: [
          SizedBox(
            height: 2.h,
          ),
          InkWell(
            onTap: () async {
              final image =
                  await ImageServices.getImageFromGallery(context: context);
              if (image != null) {
                setState(() {
                  profilePic = File(image.path);
                });
              }
            },
            child: CircleAvatar(
              radius: 8.h,
              backgroundColor: greyShade3,
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Builder(
                  builder: (context) {
                    if (profilePic != null) {
                      return CircleAvatar(
                        radius: (8.h - 2),
                        backgroundColor: white,
                        backgroundImage: FileImage(profilePic!),
                      );
                    } else {
                      return CircleAvatar(
                        radius: (8.h - 2),
                        backgroundColor: white,
                        child: const Image(
                            image: AssetImage(
                                'assets/images/uberLogo/uberLogoBlack.png')),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          RegistrationScreenTextField(
            controller: nameController,
            hint: '',
            title: 'Name',
            keyBoardType: TextInputType.name,
            readOnly: false,
          ),
          SizedBox(
            height: 4.h,
          ),
          RegistrationScreenTextField(
            controller: mobileController,
            hint: '',
            title: 'Mobile Number',
            keyBoardType: TextInputType.name,
            readOnly: true,
          ),
          SizedBox(
            height: 4.h,
          ),
          RegistrationScreenTextField(
            controller: emailController,
            hint: '',
            title: 'Email',
            keyBoardType: TextInputType.name,
            readOnly: false,
          ),
          SizedBox(
            height: 4.h,
          ),
          selectUserType('Customer'),
          SizedBox(
            height: 2.h,
          ),
          selectUserType('Partner'),
          SizedBox(
            height: 4.h,
          ),
          Builder(
            builder: (context) {
              if (userType == 'Partner') {
                return Partner();
              } else {
                return Customer();
              }
            },
          ),
        ],
      ),
    ));
  }

  selectUserType(String updateUserType) {
    return InkWell(
      onTap: () {
        if (registerButtonPressed == false) {
          setState(() {
            userType = updateUserType;
          });
        }
      },
      child: Row(
        children: [
          Container(
            height: 2.5.h,
            width: 2.5.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.sp),
              border: Border.all(
                color: userType == updateUserType ? black : grey,
              ),
            ),
            child: Icon(
              Icons.check,
              color: userType == updateUserType ? black : transparent,
            ),
          ),
          SizedBox(width: 3.h),
          Text(
            'Continue as a ${updateUserType}',
            style: AppTextStyles.small10.copyWith(
              color: userType == updateUserType ? black : grey,
            ),
          )
        ],
      ),
    );
  }

  Customer() {
    return Column(
      children: [
        SizedBox(
          height: 15.h,
        ),
        ElevatedButtonCommon(
          onPressed: () async {
            setState(() {
              registerButtonPressed == true;
            });
            await registerCustomer();
          },
          backgroundColor: black,
          width: 94.w,
          height: 6.h,
          child: registerButtonPressed == true
              ? CircularProgressIndicator(color: white)
              : Text(
                  'Continue',
                  style: AppTextStyles.small12Bold.copyWith(color: white),
                ),
        ),
      ],
    );
  }

  Partner() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RegistrationScreenTextField(
          controller: vehicleBrandNameController,
          hint: '',
          title: 'Vhicle Brand Name',
          keyBoardType: TextInputType.name,
          readOnly: true,
        ),
        SizedBox(
          height: 2.h,
        ),
        RegistrationScreenTextField(
          controller: vehicleModelNameColtroller,
          hint: '',
          title: 'Vhicle Model',
          keyBoardType: TextInputType.name,
          readOnly: true,
        ),
        SizedBox(
          height: 2.h,
        ),
        Text('Vhicle Type', style: AppTextStyles.body14Bold),
        SizedBox(height: 1.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.sp),
              border: Border.all(color: grey)),
          child: DropdownButton(
            isExpanded: true,
            value: selectedVehicleType,
            underline: const SizedBox(),
            icon: const Icon(Icons.keyboard_arrow_down),
            items: VhicleTypes.map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  style: AppTextStyles.small12,
                ),
              ),
            ).toList(),
            onChanged: (value) {
              setState(() {
                selectedVehicleType = value!;
              });
            },
          ),
        ),
        SizedBox(height: 2.h),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       'Vhicle Type',
        //       style: AppTextStyles.body14Bold,
        //     )
        //   ],
        // ),
        SizedBox(height: 1.h),
        RegistrationScreenTextField(
          controller: vehicleRegistrationNumberController,
          hint: '',
          title: 'Vhicle Registration No.',
          keyBoardType: TextInputType.name,
          readOnly: true,
        ),
        SizedBox(
          height: 2.h,
        ),
        RegistrationScreenTextField(
          controller: drivingLicenseNumberController,
          hint: '',
          title: 'Driving Licences No.',
          keyBoardType: TextInputType.name,
          readOnly: true,
        ),
        SizedBox(
          height: 2.h,
        ),
        ElevatedButtonCommon(
          onPressed: () async {
            setState(() {
              registerButtonPressed == true;
            });
            await registerDriver();
          },
          backgroundColor: black,
          width: 94.w,
          height: 6.h,
          child: registerButtonPressed == true
              ? CircularProgressIndicator(color: white)
              : Text(
                  'Continue',
                  style: AppTextStyles.small12Bold.copyWith(color: white),
                ),
        ),
      ],
    );
  }
}

class RegistrationScreenTextField extends StatefulWidget {
  const RegistrationScreenTextField(
      {super.key,
      required this.controller,
      required this.title,
      required this.hint,
      required this.readOnly,
      required this.keyBoardType});

  final TextEditingController controller;
  final String title;
  final String hint;
  final bool readOnly;
  final TextInputType keyBoardType;

  @override
  State<RegistrationScreenTextField> createState() =>
      _RegistrationScreenTextFieldState();
}

class _RegistrationScreenTextFieldState
    extends State<RegistrationScreenTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppTextStyles.body14,
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: widget.controller,
          cursorColor: black,
          style: AppTextStyles.textFieldTextStyle,
          keyboardType: widget.keyBoardType,
          readOnly: widget.readOnly,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 2.w),
            hintText: widget.hint,
            hintStyle: AppTextStyles.textFieldHintTextStyle,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.sp),
              borderSide: BorderSide(
                color: grey,
              ),
            ),
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
        )
      ],
    );
  }
}
