import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:future/home_page/course_content_student.dart';
import 'package:future/home_page/course_content_teacher.dart';
import 'package:future/home_page/teacher/course_editing_page.dart';

class CourseCard extends StatefulWidget {
  final Image image;
  final String title;
  final String description;

  final double percentage;
  final Color color;

  CourseCard({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.percentage,
    required this.color,
  }) : super(key: key);

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  final _auth = FirebaseAuth.instance;

  late bool teachersOnly;
  String? courseId;
  String? oldTitle;
  String appRole = 'student';

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  //get the name in the cloud firestore
  void getCurrentUser() async {
    final user = _auth.currentUser;

    try {
      if (user != null) {
        var collection = FirebaseFirestore.instance.collection('users');
        var docSnapshot = await collection.doc(user.uid).get();
        if (docSnapshot.exists) {
          Map<String, dynamic>? data = docSnapshot.data();
          var role = data?['role']; // <-- The value you want to retrieve.

          setState(() {
            appRole = role.toString();

            try {
              FirebaseFirestore.instance.collection('courses').get().then(
                  (QuerySnapshot snapshot) =>
                      snapshot.docs.forEach((DocumentSnapshot doc) {
                        setState(() {
                          if (doc.get('title') == widget.title) {
                            oldTitle = doc.get('oldtitle');
                            courseId = doc.get('courseid');

                            print(courseId);
                            print(oldTitle);
                          }
                        });
                      }));
            } catch (e) {
              print(e);
            }
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (appRole == 'student') {
      teachersOnly = false;
    } else if (appRole == 'teacher') {
      teachersOnly = true;
    }

    return GestureDetector(
      onLongPress: () {
        final user = _auth.currentUser;

        if (teachersOnly & (courseId == ((user?.uid)! + oldTitle!))) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CourseEditingPage(
                passedCourseCard: widget.title,
              ),
            ),
          );
        }
      },
      onTap: () {
        if (teachersOnly) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CourseContentTeacher(
                passedCourseCard: widget.title,
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CourseContentStudent(
                passedCourseCard: widget.title,
              ),
            ),
          );
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(30.0),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: widget.color,
        ),
        child: Row(
          children: <Widget>[
            widget.image,
            SizedBox(width: 40.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFFF18C8E),
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   width: 20,
            // ),
            // Row(
            //   children: <Widget>[
            //     Text(
            //       widget.progress,
            //       style: TextStyle(
            //         fontSize: 13,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.black87,
            //       ),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
