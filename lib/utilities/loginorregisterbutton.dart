import 'package:flutter/material.dart';

class LoginorRegiserButton extends StatelessWidget {
  LoginorRegiserButton({required this.text, required this.onPressed});
  final text;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF7E8CE0),
          onPrimary: Colors.white,
          elevation: 5.0,
          shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ));
  }
}
