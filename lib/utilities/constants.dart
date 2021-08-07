import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const kLoginorRegiserText = TextStyle(
  fontWeight: FontWeight.bold,
  fontFamily: 'Montserrat',
  fontSize: 35.0,
);

const kDescText = TextStyle(
  fontSize: 12.0,
  color: Colors.grey,
  fontFamily: 'Raleway',
);

const kSubHeading =
    TextStyle(fontSize: 22.0, color: Colors.white, fontFamily: 'Montserrat');

const kTextFieldInputDecoration = InputDecoration(
    icon: Icon(
      FontAwesomeIcons.envelope,
      size: 20,
      color: Colors.white,
    ),
    filled: true,
    focusColor: Color.fromRGBO(36, 36, 62, 1),
    hintText: '',
    hintStyle: TextStyle(
      color: Colors.grey,
      fontSize: 12,
    ));

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);
