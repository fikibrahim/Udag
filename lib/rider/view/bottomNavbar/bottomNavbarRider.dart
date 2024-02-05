import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:uber/common/view/driverHomeScreen.dart';
import 'package:uber/constant/utils/colors.dart';
import 'package:uber/driver/controller/bottomNavBarRiderProvider.dart';
import 'package:uber/driver/view/accountScreenDriver/acountScreenDriver.dart';
import 'package:uber/driver/view/activityScreenDriver/activityScreenDriver.dart';
import 'package:uber/rider/controller/provider/bottomNavBarRiderProvider/bottomNavBarRiderProvider.dart';
import 'package:uber/rider/view/account/acountScreenRider.dart';
import 'package:uber/rider/view/activity/activityScreen.dart';
import 'package:uber/rider/view/homeScreen/riderHomeScreen.dart';

import 'package:uber/rider/view/serviceScreen/serviceScreen.dart';

class BottomNavbarRider extends StatefulWidget {
  const BottomNavbarRider({super.key});

  @override
  State<BottomNavbarRider> createState() => _BottomNavbarRiderState();
}

class _BottomNavbarRiderState extends State<BottomNavbarRider> {
  List<Widget> screens = [
    const HomeScreenDriver(),
    const ActivityScreendDriver(),
    // const ServiceScreenRider(),
    const AccountScreenDriver()
  ];

  List<PersistentBottomNavBarItem> _navBarItem(int currentTab) {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(currentTab == 0
              ? CupertinoIcons.house_fill
              : CupertinoIcons.house),
          title: 'Home',
          activeColorPrimary: black,
          inactiveColorPrimary: grey),
      // PersistentBottomNavBarItem(
      //     icon: Icon(currentTab == 0
      //         ? CupertinoIcons.circle_grid_3x3_fill
      //         : CupertinoIcons.circle_grid_3x3),
      //     title: 'Services',
      //     activeColorPrimary: black,
      //     inactiveColorPrimary: grey),
      PersistentBottomNavBarItem(
          icon: Icon(currentTab == 0
              ? CupertinoIcons.square_list_fill
              : CupertinoIcons.square_list),
          title: 'Activity',
          activeColorPrimary: black,
          inactiveColorPrimary: grey),
      PersistentBottomNavBarItem(
          icon: Icon(currentTab == 0
              ? CupertinoIcons.person_fill
              : CupertinoIcons.person),
          title: 'Account',
          activeColorPrimary: black,
          inactiveColorPrimary: grey)
    ];
  }

  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavbarDriverProvider>(
      builder: (context, tabProvider, child) {
        return PersistentTabView(
          context,
          screens: screens,
          controller: controller,
          items: _navBarItem(tabProvider.currentTab),
          confineInSafeArea: true,
          onItemSelected: (value) {
            tabProvider.updateTab(value);
            print(value.toString());
          },
          backgroundColor: white,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(8.sp),
              colorBehindNavBar: white),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
              duration: Duration(milliseconds: 200), curve: Curves.ease),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style6,
        );
      },
    );
  }
}
