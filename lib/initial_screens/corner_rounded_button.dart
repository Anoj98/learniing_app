import 'package:flutter/material.dart';

class CornerRoundedButton extends StatelessWidget {
  const CornerRoundedButton({
    Key? key,
    required this.btnText,
    required this.onPress,
  }) : super(key: key);
  final String btnText;
  final Function() onPress;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.0,
      width: 90.0,
      child: ElevatedButton(
        child: Text(
          btnText.toUpperCase(),
          style: const TextStyle(fontSize: 14, color: Colors.green),
        ),
        style: ButtonStyle(
          //TODO: what is this foreground color
          //foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: Colors.green),
            ),
          ),
        ),
        onPressed: onPress,
      ),
    );
  }
}
