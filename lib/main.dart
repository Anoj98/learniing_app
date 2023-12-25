import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:future/account_page/account_page.dart';
import 'package:future/constants.dart';
import 'package:future/home_page/course_content_student.dart';
import 'package:future/home_page/course_content_teacher.dart';
import 'package:future/home_page/teacher/new_course_data_input_page.dart';
import 'package:future/initial_screens/login/login.dart';
import 'package:future/initial_screens/signup/signup.dart';
import 'package:future/initial_screens/splash_screen.dart';
import 'package:future/initial_screens/welcome/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_navigation_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Future',
        theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: kPrimaryColor,
        ),
        initialRoute: SplashScreen.id,
        routes: {
          Welcome.id: (context) => Welcome(),
          Login.id: (context) => Login(),
          Signup.id: (context) => Signup(),
          BottomNavigationHome.id: (context) => BottomNavigationHome(),
          NewCourseDataInput.id: (context) => NewCourseDataInput(),
          AccountPage.id: (context) => AccountPage(),
          SplashScreen.id: (context) => SplashScreen(),
        });
  }
}
