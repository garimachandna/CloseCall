// @dart=2.9

import 'package:flutter/material.dart';
import 'utilities/optionbutton.dart';
import '../loginpage.dart';
import 'registrationpage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(1, 0.0),
          colors: <Color>[
            Color.fromRGBO(48, 43, 99, 1),
            Color.fromRGBO(15, 12, 41, 0.95),
            Color.fromRGBO(36, 36, 62, 1),
          ], // red to yellow
          tileMode: TileMode.mirror, // repeats the gradient over the canvas
        ),
        image: DecorationImage(
          image: AssetImage('assets/images/Rectangle 12.png'),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
            child: Flexible(
              child: Row(
                children: [
                  Flexible(
                    child: Image(
                      image: AssetImage('assets/images/closecall-logo.png'),
                      width: 120,
                      height: 120,
                    ),
                  ),
                  SizedBox(width: 13),
                  Flexible(
                    child: Text(
                      'CloseCall',
                      style: TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.only(top: 80),
              width: 128,
              child: Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 22.0,
                  fontFamily: 'Raleway',
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 45,
          ),
          OptionButton(
            data: 'Log In',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginPage();
              }));
            },
          ),
          OptionButton(
            data: 'Register',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return RegistrationPage();
              }));
            },
          ),
        ],
      ),
    );
  }
}
