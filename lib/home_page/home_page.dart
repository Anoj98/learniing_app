import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:future/home_page/course_card.dart';
import 'package:future/home_page/search_box.dart';
import 'package:future/home_page/teacher/add_new_course_card.dart';
import 'package:future/home_page/teacher/new_course_data_input_page.dart';

import '../account_page/account_page.dart';
import '../bottom_navigation_home.dart';
import '../constants.dart';
import 'clipper.dart';
import 'custom_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;

  String myUserName = ' ';
  String appRole = 'student';
  late bool teachersOnly;
  List<String> coursesTitle = [];
  List<String> coursesDescription = [];
  List<Widget> courseCards = [];

  @override
  void initState() {
    getCurrentUser();
    getCourses();
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
          var role = data?['role'];
          var name = data?['name']; // <-- The value you want to retrieve.

          setState(() {
            appRole = role.toString();
            myUserName = name.toString();
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void getCourses() async {
    //User? user = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseFirestore.instance.collection('courses').get().then(
          (QuerySnapshot snapshot) =>
              snapshot.docs.forEach((DocumentSnapshot doc) {
                setState(() {
                  // coursesTitle.add(doc.get('title'));
                  // coursesDescription.add(doc.get('description'));
                  if (doc.data() != null) {
                    courseCards.add(
                      CourseCard(
                          image: Image.network(
                            doc.get('course_pic'),
                            height: 50,
                            width: 50,
                          ),
                          title: doc.get('title'),
                          description: doc.get('description'),
                          percentage: 56,
                          color: Colors.white),
                    );
                  }
                  print(coursesTitle);
                });
              }));
    } catch (e) {
      print(e);
    }
  }

  //check whether teacher or student
  @override
  Widget build(BuildContext context) {
    if (appRole == 'student') {
      teachersOnly = false;
    } else if (appRole == 'teacher') {
      teachersOnly = true;
    }

    // take the size of screen
    var size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: Visibility(
        visible: teachersOnly,
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, NewCourseDataInput.id);
          },
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Dashboard'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, BottomNavigationHome.id);
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                //add the colored art at the top
                ClipPath(
                  clipper: BottomClipper(),
                  child: Container(
                      width: size.width,
                      height: 200.0,
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 75),

                      //heading
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomHeading(
                            title: 'Hi, ' + myUserName,
                            subTitle: 'Let\'s start learning.',
                            color: Colors.white,
                          ),
                          // Container(
                          //   height: 50,
                          //   width: 50,
                          //   child: ClipRRect(
                          //     borderRadius: BorderRadius.circular(100),
                          //     child: CircleAvatar(),
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      //SearchBox(),
                      SizedBox(height: 100),

                      // Visibility(
                      //   visible: teachersOnly,
                      //   child: AddNewCoursesCard(),
                      // ),

                      Column(children: courseCards),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class NavigationDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(padding: EdgeInsets.zero, children: <Widget>[
//         DrawerHeader(
//           child: Text(
//             'Side menu',
//             style: TextStyle(color: Colors.black, fontSize: 25),
//           ),
//         ),
//         ListTile(
//           leading: Icon(Icons.input),
//           title: Text('Welcome'),
//           onTap: () => {},
//         ),
//         ListTile(
//           leading: Icon(Icons.verified_user),
//           title: Text('Profile'),
//           onTap: () => {Navigator.of(context).pop()},
//         ),
//         ListTile(
//           leading: Icon(Icons.settings),
//           title: Text('Settings'),
//           onTap: () => {Navigator.pushNamed(context, AccountPage.id)},
//         ),
//         ListTile(
//           leading: Icon(Icons.border_color),
//           title: Text('Feedback'),
//           onTap: () => {Navigator.of(context).pop()},
//         ),
//       ]),
//     );
//   }
// }
