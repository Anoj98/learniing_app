import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:future/home_page/course_content_student.dart';
import 'package:future/home_page/teacher/new_course_data_input_page.dart';

import '../course_card.dart';

class AddNewCoursesCard extends StatefulWidget {
  AddNewCoursesCard({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNewCoursesCard> createState() => _AddNewCoursesCardState();
}

class _AddNewCoursesCardState extends State<AddNewCoursesCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        child: RawMaterialButton(
          child: Icon(
            Icons.add,
            size: 50,
            color: Colors.white,
          ),
          elevation: 6.0,
          onPressed: () {
            Navigator.pushNamed(context, NewCourseDataInput.id);
          },
          constraints: BoxConstraints.tightFor(width: 56.0, height: 56.0),
          shape: CircleBorder(),
          fillColor: Color(0xFFB5B6C0),
        ),
        width: double.infinity,
        padding: EdgeInsets.all(30.0),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Color(0xffefefef),
        ),
      ),
    );
  }
}
