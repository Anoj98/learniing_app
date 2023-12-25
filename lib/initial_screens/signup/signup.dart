import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:future/constants.dart';
import 'package:future/initial_screens/corner_rounded_button.dart';
import 'package:future/initial_screens/signup/selecting_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bottom_navigation_home.dart';

import '../../constants.dart';
import '../background.dart';
import 'input_field.dart';
import 'input_password_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum Person { student, teacher }

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  static String id = 'signup';

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  late String name;
  late String role;

  Person? selectedPerson;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
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
              Text('Sign Up'),
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SelectingCard(
                    cardChild: Text('Student'),
                    onPress: () {
                      setState(() {
                        selectedPerson = Person.student;
                        role = 'student';
                      });
                    },
                    cardColor: selectedPerson == Person.student
                        ? kSelectedCardColor
                        : kUnselectedCardColor,
                  ),
                  SelectingCard(
                    cardChild: Text('Teacher'),
                    onPress: () {
                      setState(() {
                        selectedPerson = Person.teacher;
                        role = 'teacher';
                      });
                    },
                    cardColor: selectedPerson == Person.teacher
                        ? kSelectedCardColor
                        : kUnselectedCardColor,
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: 'Name',
                icon: Icons.person,
                onChanged: (value) {
                  name = value;
                },
              ),
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
                  btnText: 'sign up',
                  onPress: () async {
                    if (email.isEmpty) {
                      print("Email is Empty");
                    } else {
                      if (password.isEmpty) {
                        print("Password is Empty");
                      } else {
                        try {
                          await _auth
                              .createUserWithEmailAndPassword(
                                  email: email, password: password)
                              .then((value) async {
                            User? user = FirebaseAuth.instance.currentUser;
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(user?.uid)
                                .set({
                              'email': email,
                              'name': name,
                              'role': role,
                            });
                          });

                          final newUser = _auth.currentUser;
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
    );
  }
}
