import 'package:flutter/material.dart';

class BottomNavbarDriverProvider extends ChangeNotifier {
  int currentTab = 0;
  updateTab(int newTab) {
    currentTab = newTab;
    notifyListeners();
  }
}
