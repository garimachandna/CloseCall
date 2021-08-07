// @dart=2.9

import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:closecall_safety_app/utilities/constants.dart';
import 'package:closecall_safety_app/utilities/loginorregisterbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 60, 20, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/undraw_unlock_24mb (1).svg',
                    height: 200,
                    width: 300,
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: [
                      Text(
                        'Login',
                        style: kLoginorRegiserText,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Text(
                        'Please sign in to continue',
                        style: kDescText,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    showCursor: true,
                    decoration: kTextFieldInputDecoration.copyWith(
                      icon: Icon(FontAwesomeIcons.envelope),
                      hintText: 'EMAIL',
                    ),
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    obscureText: true,
                    showCursor: true,
                    decoration: kTextFieldInputDecoration.copyWith(
                      icon: Icon(FontAwesomeIcons.lock),
                      hintText: 'PASSWORD',
                    ),
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(
                    height: 22.0,
                  ),
                  LoginorRegiserButton(
                    text: 'Log In',
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final registereduser =
                            await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                        if (registereduser != null) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Dashboard();
                          }));
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
