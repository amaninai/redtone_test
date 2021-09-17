import 'package:flutter/material.dart';

enum DrawerItem {
  profile,
  courses,
}

class DrawerProvider extends ChangeNotifier {
  DrawerItem _drawerItem = DrawerItem.courses;
  DrawerItem get drawerItem => _drawerItem;

  void setDrawerItem(DrawerItem drawerItem) {
    _drawerItem = drawerItem;
    notifyListeners();
  }
}
