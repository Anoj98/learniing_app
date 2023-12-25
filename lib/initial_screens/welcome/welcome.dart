import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:future/bottom_navigation_home.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../background.dart';
import '../constants.dart';
import '../corner_rounded_button.dart';
import '../login/login.dart';
import '../signup/signup.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  static String id = 'welcome';

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              exit(0);
            }),
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset(
                'images/logo.png',
                height: 150.0,
                width: 150.0,
              ),
              const Text(
                "WELCOME TO FUTURE",
                style: kWelcomeTextStyle,
              ),
              SizedBox(height: size.height * 0.05),
              CornerRoundedButton(
                onPress: () {
                  Navigator.pushNamed(context, Signup.id);
                },
                btnText: 'sign up',
              ),
              SizedBox(height: size.height * 0.05),
              CornerRoundedButton(
                onPress: () {
                  Navigator.pushNamed(context, Login.id);
                },
                btnText: 'login',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
