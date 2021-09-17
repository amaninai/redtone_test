import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redtone_test/models/drawerModel.dart';
import 'package:redtone_test/screens/courseInfoScreen.dart';
import 'package:redtone_test/screens/courseScreen.dart';
import 'package:redtone_test/screens/mainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DrawerProvider(),
      child: MaterialApp(
        title: 'REDtone Test',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: MainScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          CourseScreen.routeName: (context) => CourseScreen(),
          CourseInfoScreen.routeName: (context) => CourseInfoScreen(),
        },
      ),
    );
  }
}
