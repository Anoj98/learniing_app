import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectingCard extends StatelessWidget {
  SelectingCard(
      {required this.cardColor,
      required this.cardChild,
      required this.onPress});

  final Color cardColor;
  final Widget cardChild;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 80,
        padding: EdgeInsets.all(10),
        child: cardChild,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: cardColor,
          border: Border.all(color: Color(0xff9B9B9B)),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
