import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:redtone_test/models/courseModel.dart';
import 'package:redtone_test/screens/courseInfoScreen.dart';
import 'package:redtone_test/widgets/drawerWidget.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({Key? key}) : super(key: key);
  static const String routeName = '/courseList';

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  int total = 0;
  List<Course> courses = [];
  final controller = ScrollController();
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  Future<void> readJsonFile() async {
    final String response =
        await rootBundle.loadString('assets/files/course.json');
    final courseData = await json.decode(response);
    var amount = courseData['total'] as int;
    var list = courseData['courses'] as List<dynamic>;

    setState(() {
      total = amount;
      courses = list.map((e) => Course.fromJson(e)).toList();
    });
  }

  void scrollUp() {
    final double start = 0.0;

    controller.animateTo(
      start,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  @override
  void initState() {
    readJsonFile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF9EE),
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text('Courses'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scrollUp,
        mini: true,
        backgroundColor: Colors.white70,
        child: Icon(Icons.arrow_upward, color: Colors.black54),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: displayCourseList(),
      ),
    );
  }

  displayCourseList() {
    if (courses.isEmpty || courses.length == 0)
      // return Center(child: Text('No courses available'));
      return Center(child: CircularProgressIndicator());
    else
      return ListView.builder(
        controller: controller,
        itemCount: courses.length,
        itemBuilder: (context, index) {
          DateTime start = dateFormat.parse(courses[index].start);
          String startDate = DateFormat('dd/MM/yy').format(start);
          DateTime end = dateFormat.parse(courses[index].end);
          String endDate = DateFormat('dd/MM/yy').format(end);

          return Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(11.0)),
              ),
              child: InkWell(
                onTap: () => Navigator.of(context).pushNamed(
                  CourseInfoScreen.routeName,
                  arguments: jsonEncode(courses[index]),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.date_range,
                            size: 13.0,
                            color: Colors.redAccent,
                          ),
                          SizedBox(width: 5.0),
                          Text(
                            '$startDate \u2013 $endDate',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      Divider(thickness: 1.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            courses[index].title,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          buildText(courses[index].description),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
  }

  Widget buildText(String text) {
    final styleButton = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.red,
    );

    return ReadMoreText(
      text,
      trimLines: 3,
      trimMode: TrimMode.Line,
      trimCollapsedText: 'Read More',
      trimExpandedText: 'Show Less',
      lessStyle: styleButton,
      moreStyle: styleButton,
      style: TextStyle(color: Colors.black),
    );
  }
}
