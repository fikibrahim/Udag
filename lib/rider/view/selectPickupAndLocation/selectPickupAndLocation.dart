// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:uber/common/controlrer/provider/locationProvider.dart';
import 'package:uber/common/controlrer/services/locationService.dart';
import 'package:uber/common/model/pickupNDropLocation.dart';
import 'package:uber/common/model/searchAddressModel.dart';
import 'package:uber/constant/utils/colors.dart';
import 'package:uber/constant/utils/textStyles.dart';

class PickupAndDropLocationScreen extends StatefulWidget {
  const PickupAndDropLocationScreen({super.key});

  @override
  State<PickupAndDropLocationScreen> createState() =>
      _PickupAndDropLocationScreenState();
}

class _PickupAndDropLocationScreenState
    extends State<PickupAndDropLocationScreen> {
  TextEditingController pickupLocationController = TextEditingController();
  TextEditingController dropLocationController = TextEditingController();

  getCurrentAddress() async {
    LatLng crrLocation = await LocationServices.getCurrentLocation();
    PickupNDropLocationModel currentLocationAddress =
        await LocationServices.getAddressFromLatLng(
            position: crrLocation, context: context);

    pickupLocationController.text = currentLocationAddress.name!;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCurrentAddress();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(100.w, 22.h),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 3.w,
                  vertical: 1.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 4.h,
                        color: black,
                      ),
                    ),
                    Expanded(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.5.h),
                          child: Column(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 2.h,
                                color: black,
                              ),
                              Expanded(
                                child: Container(
                                  width: 1.w,
                                  color: black,
                                  padding:
                                      EdgeInsets.symmetric(vertical: 0.5.h),
                                ),
                              ),
                              Icon(
                                Icons.square,
                                size: 2.h,
                                color: black,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextFormField(
                                controller: pickupLocationController,
                                cursorColor: black,
                                style: AppTextStyles.textFieldTextStyle,
                                keyboardType: TextInputType.name,
                                onChanged: (value) {
                                  LocationServices.getSearchAddress(
                                      placeName: value, context: context);
                                },
                                decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      pickupLocationController.clear();
                                    },
                                    child: Icon(
                                      CupertinoIcons.xmark,
                                      color: black,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 2.w),
                                  hintText: 'Pickup Address',
                                  hintStyle:
                                      AppTextStyles.textFieldHintTextStyle,
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

                              TextFormField(
                                controller: dropLocationController,
                                cursorColor: black,
                                style: AppTextStyles.textFieldTextStyle,
                                keyboardType: TextInputType.name,
                                onChanged: (value) {
                                  LocationServices.getSearchAddress(
                                    placeName: value,
                                    context: context,
                                  );
                                },
                                decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      dropLocationController.clear();
                                    },
                                    child: Icon(
                                      CupertinoIcons.xmark,
                                      color: black,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 2.w),
                                  hintText: 'Drop Address',
                                  hintStyle:
                                      AppTextStyles.textFieldHintTextStyle,
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

                              
                            ],
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ),
            body: Consumer<LocationProvider>(
              builder: (context, locationProvider, child) {
                if (locationProvider.searchAddress.isEmpty) {
                  return Center(
                    child: Text(
                      'Search Address',
                      style: AppTextStyles.small12,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: locationProvider.searchAddress.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      SearchAddressModel currentAddress =
                          locationProvider.searchAddress[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: greyShade3,
                          radius: 4.h,
                          child: Icon(
                            Icons.location_on,
                            color: black,
                          ),
                        ),
                        title: Text(currentAddress.mainName,
                            style: AppTextStyles.small12Bold),
                        subtitle: Text(
                          currentAddress.mainName,
                          style: AppTextStyles.small10.copyWith(color: grey),
                        ),
                      );
                    },
                  );
                }
              },
            )));
  }
}
