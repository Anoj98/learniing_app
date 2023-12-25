import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:future/initial_screens/constants.dart';

class CourseContentStudent extends StatefulWidget {
  final String passedCourseCard;

  const CourseContentStudent({
    Key? key,
    required this.passedCourseCard,
  }) : super(key: key);

  @override
  State<CourseContentStudent> createState() => _CourseContentStudentState();
}

class _CourseContentStudentState extends State<CourseContentStudent> {
  String topic = ' ';
  String author = ' ';
  List<Widget> texts = [];
  String? title;
  String? oldTitle;
  String? liked;

  @override
  void initState() {
    getClickedCourse();

    super.initState();
  }

//check witch course card selected

  void getClickedCourse() async {
    //User? user = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseFirestore.instance.collection('courses').get().then(
          (QuerySnapshot snapshot) =>
              snapshot.docs.forEach((DocumentSnapshot doc) {
                setState(() {
                  if (doc.get('title') == widget.passedCourseCard) {
                    oldTitle = doc.get('oldtitle');
                    texts.add(Text(
                      doc.get('title'),
                      style: kWelcomeTextStyle,
                    ));
                    texts.add(SizedBox(
                      height: 10.0,
                    ));
                    texts.add(Text(
                      doc.get('description'),
                      style: kDescriptionTextStyle,
                    ));

                    for (int i = 0; i <= doc.get('itemcount'); i++) {
                      switch (i) {
                        case 0:
                          {
                            if ((doc.get('new_item_field_list')[i]) ==
                                'title') {
                              texts.add(Text(
                                doc.get('title1'),
                                style: kSubtitleTextStyle,
                              ));
                            }
                            if ((doc.get('new_item_field_list')[i]) ==
                                'description') {
                              texts.add(Text(doc.get('description1')));
                            }
                          }
                          break;
                        case 1:
                          {
                            if ((doc.get('new_item_field_list')[i]) ==
                                'title') {
                              texts.add(Text(
                                doc.get('title2'),
                                style: kSubtitleTextStyle,
                              ));
                            }
                            if ((doc.get('new_item_field_list')[i]) ==
                                'description') {
                              texts.add(Text(doc.get('description2')));
                            }
                          }
                          break;

                        case 2:
                          {
                            if ((doc.get('new_item_field_list')[i]) ==
                                'title') {
                              texts.add(Text(
                                doc.get('title3'),
                                style: kSubtitleTextStyle,
                              ));
                            }
                            if ((doc.get('new_item_field_list')[i]) ==
                                'description') {
                              texts.add(Text(doc.get('description3')));
                            }
                          }
                          break;

                        case 3:
                          {
                            if ((doc.get('new_item_field_list')[i]) ==
                                'title') {
                              texts.add(Text(
                                doc.get('title4'),
                                style: kSubtitleTextStyle,
                              ));
                            }
                            if ((doc.get('new_item_field_list')[i]) ==
                                'description') {
                              texts.add(Text(doc.get('description4')));
                            }
                          }
                          break;

                        case 4:
                          {
                            if ((doc.get('new_item_field_list')[i]) ==
                                'title') {
                              texts.add(Text(
                                doc.get('title5'),
                                style: kSubtitleTextStyle,
                              ));
                            }
                            if ((doc.get('new_item_field_list')[i]) ==
                                'description') {
                              texts.add(Text(doc.get('description5')));
                            }
                          }
                          break;
                      }
                    }
                  }
                });
              }));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                User? user = FirebaseAuth.instance.currentUser;
                FirebaseFirestore.instance
                    .collection('courses')
                    .doc((user?.uid)! + title!)
                    .set({});
              },
              icon: Icon(Icons.add_circle_outline))
        ],
        title: Text('Course Content'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: texts,
        ),
      ),
    );
  }
}
