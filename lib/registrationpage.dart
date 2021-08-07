// @dart=2.9

import 'package:closecall_safety_app/loginpage.dart';
import 'dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'utilities/constants.dart';
import 'utilities/loginorregisterbutton.dart';
import 'loginpage.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            FontAwesomeIcons.arrowLeft,
          ),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      'Create Account',
                      style: kLoginorRegiserText,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Text(
                      'Please fill the input below here',
                      style: kDescText,
                    ),
                  ],
                ),
                SizedBox(
                  height: 60.0,
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
                  height: 50.0,
                ),
                LoginorRegiserButton(
                  text: 'Sign Up',
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      if (newUser != null) {
                        final refUser = FirebaseFirestore.instance
                            .collection('users')
                            .doc();
                        await refUser.set({'email': email});
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
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: kDescText,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return LoginPage();
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Sign In',
                          style: kDescText.copyWith(
                              color: Color(0xFF4ACFAC), fontSize: 17),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
