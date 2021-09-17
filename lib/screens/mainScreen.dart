import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redtone_test/models/drawerModel.dart';
import 'package:redtone_test/screens/courseScreen.dart';
import 'package:redtone_test/screens/profileScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) => buildScreens();

  Widget buildScreens() {
    final provider = Provider.of<DrawerProvider>(context);
    final drawerItem = provider.drawerItem;

    switch (drawerItem) {
      case DrawerItem.profile:
        return ProfileScreen();
      case DrawerItem.courses:
        return CourseScreen();
    }
  }
}
