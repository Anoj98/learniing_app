import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:future/initial_screens/constants.dart';

import '../../bottom_navigation_home.dart';

class CourseEditingPage extends StatefulWidget {
  final String passedCourseCard;

  const CourseEditingPage({
    Key? key,
    required this.passedCourseCard,
  }) : super(key: key);

  @override
  State<CourseEditingPage> createState() => _CourseEditingPageState();
}

class _CourseEditingPageState extends State<CourseEditingPage> {
  String topic = ' ';
  String author = ' ';
  List<Widget> texts = [];
  String? title;
  final FirebaseAuth auth = FirebaseAuth.instance;
  late String description;

  Widget? selectedPic;
  List<Widget> newFields = [];
  List<String> newItemFieldlist = [];

  int itemcount = -1;
  String? courseId;
  String? title1;
  String? description1;
  String? title2;
  String? description2;
  String? title3;
  String? description3;
  String? title4;
  String? description4;
  String? title5;
  String? description5;

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
                    courseId = doc.get('courseid');
                    title = doc.get('title');
                    description = doc.get('description');
                    title1 = doc.get('title1');
                    title2 = doc.get('title2');
                    title3 = doc.get('title3');
                    title4 = doc.get('title4');
                    title5 = doc.get('title5');
                    description1 = doc.get('description1');
                    description2 = doc.get('description2');
                    description3 = doc.get('description3');
                    description4 = doc.get('description4');
                    description5 = doc.get('description5');

                    texts.add(TextField(
                      controller: TextEditingController(text: doc.get('title')),
                      onChanged: (value) {
                        title = value;
                        print(value);
                      },
                    ));
                    texts.add(SizedBox(
                      height: 10.0,
                    ));
                    texts.add(TextField(
                      controller:
                          TextEditingController(text: doc.get('description')),
                      onChanged: (value) {
                        description = value;
                        print(value);
                      },
                    ));

                    for (int i = 0; i <= doc.get('itemcount'); i++) {
                      switch (i) {
                        case 0:
                          {
                            if ((doc.get('new_item_field_list')[i]) ==
                                'title') {
                              texts.add(TextField(
                                controller: TextEditingController(
                                    text: doc.get('title1')),
                                onChanged: (value) {
                                  title1 = value;
                                  print(value);
                                },
                              ));
                            }
                            if ((doc.get('new_item_field_list')[i]) ==
                                'description') {
                              texts.add(TextField(
                                controller: TextEditingController(
                                    text: doc.get('description1')),
                                maxLines: 5,
                                onChanged: (value) {
                                  description1 = value;
                                  print(value);
                                },
                              ));
                            }
                          }
                          break;
                        case 1:
                          {
                            if ((doc.get('new_item_field_list')[i]) ==
                                'title') {
                              texts.add(TextField(
                                controller: TextEditingController(
                                    text: doc.get('title2')),
                                onChanged: (value) {
                                  title2 = value;
                                  print(value);
                                },
                              ));
                            }
                            if ((doc.get('new_item_field_list')[i]) ==
                                'description') {
                              texts.add(TextField(
                                controller: TextEditingController(
                                    text: doc.get('description2')),
                                maxLines: 5,
                                onChanged: (value) {
                                  description2 = value;
                                  print(value);
                                },
                              ));
                            }
                          }
                          break;

                        case 2:
                          {
                            if ((doc.get('new_item_field_list')[i]) ==
                                'title') {
                              texts.add(TextField(
                                controller: TextEditingController(
                                    text: doc.get('title3')),
                                maxLines: 5,
                                onChanged: (value) {
                                  title3 = value;
                                  print(value);
                                },
                              ));
                            }
                            if ((doc.get('new_item_field_list')[i]) ==
                                'description') {
                              texts.add(TextField(
                                controller: TextEditingController(
                                    text: doc.get('description3')),
                                maxLines: 5,
                                onChanged: (value) {
                                  description3 = value;
                                  print(value);
                                },
                              ));
                            }
                          }
                          break;

                        case 3:
                          {
                            if ((doc.get('new_item_field_list')[i]) ==
                                'title') {
                              texts.add(TextField(
                                controller: TextEditingController(
                                    text: doc.get('title4')),
                                maxLines: 5,
                                onChanged: (value) {
                                  title4 = value;
                                  print(value);
                                },
                              ));
                            }
                            if ((doc.get('new_item_field_list')[i]) ==
                                'description') {
                              texts.add(TextField(
                                controller: TextEditingController(
                                    text: doc.get('description4')),
                                maxLines: 5,
                                onChanged: (value) {
                                  description4 = value;
                                  print(value);
                                },
                              ));
                            }
                          }
                          break;

                        case 4:
                          {
                            if ((doc.get('new_item_field_list')[i]) ==
                                'title') {
                              texts.add(TextField(
                                controller: TextEditingController(
                                    text: doc.get('title5')),
                                maxLines: 5,
                                onChanged: (value) {
                                  title5 = value;
                                  print(value);
                                },
                              ));
                            }
                            if ((doc.get('new_item_field_list')[i]) ==
                                'description') {
                              texts.add(TextField(
                                controller: TextEditingController(
                                    text: doc.get('description5')),
                                maxLines: 5,
                                onChanged: (value) {
                                  description5 = value;
                                  print(value);
                                },
                              ));
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
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: () async {
                if (title!.isEmpty) {
                  print('empty title');
                } else if (description.isEmpty) {
                  print('empty description');
                } else {
                  try {
                    //User? user = FirebaseAuth.instance.currentUser;
                    await FirebaseFirestore.instance
                        .collection('courses')
                        .doc(courseId)
                        .update({
                      //'course_pic': _image,
                      'title': title,
                      'description': description,
                      //'new_item_field_list': newItemFieldlist,
                      'title1': title1,
                      'description1': description1,
                      'title2': title2,
                      'description2': description2,
                      'title3': title3,
                      'description3': description3,
                      'title4': title4,
                      'description4': description4,
                      'title5': title5,
                      'description5': description5,
                      //'itemcount': itemcount,
                      //'uid': uid,
                    });
                    if (description != null) {
                      if (title != null) {
                        Navigator.pushNamed(context, BottomNavigationHome.id);
                      }
                    }
                  } catch (e) {
                    print(e);
                  }
                }
              },
              icon: Icon(Icons.save),
            ),
          ),
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
