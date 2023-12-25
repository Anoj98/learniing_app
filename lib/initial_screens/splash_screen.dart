import 'package:flutter/material.dart';
import 'package:future/initial_screens/welcome/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bottom_navigation_home.dart';

String? finalEmail;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static String id = 'splashscreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getValidation().whenComplete(() => finalEmail == null
        ? Navigator.pushNamed(context, Welcome.id)
        : Navigator.pushNamed(context, BottomNavigationHome.id));
    super.initState();
  }

  Future getValidation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var obtainedEmail = prefs.getString('email');
    setState(() {
      finalEmail = obtainedEmail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Splash'),
    );
  }
}
