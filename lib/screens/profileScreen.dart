import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:redtone_test/models/profileModel.dart';
import 'package:redtone_test/widgets/drawerWidget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Profile> profile = [];
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  // List<Profile> currentList = [];
  String year = 'All';

  Future<void> readJsonFile() async {
    final String response =
        await rootBundle.loadString('assets/files/personal.json');
    final profileData = await json.decode(response);
    var list = profileData as List<dynamic>;
    list.removeWhere((value) => value == null);

    setState(() {
      profile = list.map((e) => Profile.fromJson(e)).toList();
    });
  }

  // filterProfile() {
  //   List<Profile> tmp = [];
  //   currentList.clear();
  //
  //   if (year != 'all') {
  //     tmp = [];
  //     for (Profile p in currentList) if (p.label == year) tmp.add(p);
  //     currentList = tmp;
  //   }
  // }

  @override
  void initState() {
    readJsonFile();
    // filterProfile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // filterProfile();

    return Scaffold(
      backgroundColor: Color(0xFFFDF9EE),
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ListTile(
              trailing: DropdownButton(
                onChanged: (item) {
                  setState(() {
                    year = item.toString();
                  });
                },
                hint: Text('Filter by', style: TextStyle(fontSize: 12.0)),
                items: [
                  DropdownMenuItem<String>(
                    child: Text('All'),
                    value: 'All',
                  ),
                  for (int i = 0; i < profile.length; i++)
                    DropdownMenuItem(
                      child: Text(profile[i].label),
                      value: profile[i].label,
                    ),
                ],
              ),
            ),
            Expanded(child: displayProfileList()),
          ],
        ),
      ),
    );
  }

  displayProfileList() {
    if (profile.isEmpty || profile.length == 0)
      // return Center(child: Text('No courses available'));
      return Center(child: CircularProgressIndicator());
    else
      return ListView.builder(
        shrinkWrap: true,
        itemCount: profile.length,
        // itemCount: currentList.length,
        itemBuilder: (context, index) {
          return ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: profile[index].status.personalCourse.length,
            // itemCount: currentList[index].status.personalCourse.length,
            itemBuilder: (cont, ind) {
              DateTime start = dateFormat
                  .parse(profile[index].status.personalCourse[ind].start);
              // DateTime start = dateFormat
              //     .parse(currentList[index].status.personalCourse[ind].start);
              String startDate = DateFormat('dd/MM/yy').format(start);
              DateTime end = dateFormat
                  .parse(profile[index].status.personalCourse[ind].end);
              // DateTime end = dateFormat
              //     .parse(currentList[index].status.personalCourse[ind].end);
              String endDate = DateFormat('dd/MM/yy').format(end);

              return Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.5)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile[index].status.personalCourse[ind].title,
                          // currentList[index].status.personalCourse[ind].title,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Row(
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
                        SizedBox(height: 10.0),
                        buildText(profile[index]
                            .status
                            .personalCourse[ind]
                            .description),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ),
              );
            },
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
