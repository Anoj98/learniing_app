import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_page/course_card.dart';
import '../initial_screens/login/login.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  static String id = 'account_page';

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  List<Widget> courseCards = [];

  @override
  void initState() {
    getClickedCourse();

    super.initState();
  }

//check witch course card selected

  void getClickedCourse() async {
    String? user = FirebaseAuth.instance.currentUser?.uid;
    try {
      await FirebaseFirestore.instance.collection('courses').get().then(
          (QuerySnapshot snapshot) =>
              snapshot.docs.forEach((DocumentSnapshot doc) {
                setState(() {
                  if (doc.get('uid') == user) {
                    print(user);
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
        title: Text('My Courses'),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                Navigator.pushNamed(context, AccountPage.id);
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: courseCards,
            ),
            SizedBox(
              height: 100,
            ),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final _auth = FirebaseAuth.instance;
                      _auth.signOut();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.clear();
                      Navigator.pushNamed(context, Login.id);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    child: Text('Log Out'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
