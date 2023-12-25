import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:future/constants.dart';
import 'package:future/initial_screens/welcome/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bottom_navigation_home.dart';
import '../background.dart';
import '../corner_rounded_button.dart';
import '../signup/input_field.dart';
import '../signup/input_password_field.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  static String id = 'login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushNamed(context, Welcome.id);
              }),
        ),
        body: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/logo.png',
                  height: 150.0,
                  width: 150.0,
                ),
                Text('login'),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  icon: Icons.mail_rounded,
                  hintText: "Your Email",
                  onChanged: (value) {
                    email = value;
                  },
                ),
                SizedBox(height: size.height * 0.03),
                RoundedPasswordField(
                  onChanged: (value) {
                    password = value;
                  },
                ),
                SizedBox(height: size.height * 0.03),
                CornerRoundedButton(
                    btnText: 'login',
                    onPress: () async {
                      final SharedPreferences sharedpreferences =
                          await SharedPreferences.getInstance();
                      sharedpreferences.setString('email', email);

                      if (email.isEmpty) {
                        print("Email is Empty");
                      } else {
                        if (password.isEmpty) {
                          print("Password is Empty");
                        } else {
                          try {
                            final newUser =
                                await _auth.signInWithEmailAndPassword(
                                    email: email, password: password);
                            if (newUser != null) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('email', email);
                              Navigator.pushNamed(
                                  context, BottomNavigationHome.id);
                            }
                          } catch (e) {
                            print(e);
                          }
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
