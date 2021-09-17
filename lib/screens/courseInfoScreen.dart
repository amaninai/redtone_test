import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redtone_test/models/courseModel.dart';

class CourseInfoScreen extends StatefulWidget {
  const CourseInfoScreen({Key? key}) : super(key: key);
  static const String routeName = '/courseInfo';

  @override
  _CourseInfoScreenState createState() => _CourseInfoScreenState();
}

class _CourseInfoScreenState extends State<CourseInfoScreen> {
  var courseTitle = '';
  Course? course;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String dates = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    var courseString = ModalRoute.of(context)?.settings.arguments as String;
    var courseJson = jsonDecode(courseString);

    setState(() {
      course = Course.fromJson(courseJson);
      courseTitle = course!.title;
      DateTime start = dateFormat.parse(course!.start);
      String startDate = DateFormat('dd/MM/yy').format(start);
      DateTime end = dateFormat.parse(course!.end);
      String endDate = DateFormat('dd/MM/yy').format(end);
      dates = '$startDate \u2013 $endDate';
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF9EE),
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.white70,
        child: Icon(Icons.clear, color: Colors.black54),
        onPressed: () => Navigator.pop(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(11.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Text(
                        course!.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 35.0, bottom: 25.0),
                      child: Text(
                        course!.description,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: <Widget>[
                          CourseInfoTile(
                            iconData: Icons.date_range,
                            category: 'Dates',
                            categoryInfo: dates,
                          ),
                          CourseInfoTile(
                            iconData: Icons.location_pin,
                            category: 'Location',
                            categoryInfo: course!.location,
                          ),
                          CourseInfoTile(
                            iconData: Icons.access_time,
                            category: 'Duration',
                            categoryInfo: '${course!.duration} hours',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CourseInfoTile extends StatelessWidget {
  final IconData iconData;
  final String category;
  final String categoryInfo;

  const CourseInfoTile({
    Key? key,
    required this.iconData,
    required this.category,
    required this.categoryInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconData,
        size: 23.0,
        color: Colors.redAccent,
      ),
      title: Text(
        category,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
      subtitle: Text(
        categoryInfo,
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
    );
  }
}
