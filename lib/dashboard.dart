// @dart=2.9

import 'package:closecall_safety_app/chatroom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  Map<String, dynamic> userMap;

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return '$user1$user2';
    } else {
      return '$user2$user1';
    }
  }

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    setState(() {
      isLoading = true;
    });
    await _firestore
        .collection('users')
        .where('email', isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CLoseCall',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: isLoading
              ? Center(
                  child: Container(
                    height: size.height / 20,
                    width: size.height / 20,
                    child: CircularProgressIndicator(),
                  ),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: size.height / 20,
                    ),
                    Container(
                      height: size.height / 14,
                      width: size.width,
                      alignment: Alignment.center,
                      child: Container(
                        height: size.height / 14,
                        width: size.width / 1.15,
                        child: TextField(
                          controller: _search,
                          decoration: InputDecoration(
                            hintText: 'Search by Email...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 50,
                    ),
                    ElevatedButton(
                      clipBehavior: Clip.antiAlias,
                      autofocus: true,
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(5.0),
                        overlayColor: MaterialStateProperty.all(
                          Color(0xFF4acfac),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xFF4acfac),
                        ),
                      ),
                      onPressed: onSearch,
                      child: Text('Search'),
                    ),
                    SizedBox(
                      height: size.height / 30,
                    ),
                    userMap != null
                        ? ListTile(
                            onTap: () {
                              String roomId = chatRoomId(
                                  FirebaseAuth.instance.currentUser.email,
                                  userMap['email']);

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ChatRoom(
                                  chatRoomId: roomId,
                                  userMap: userMap,
                                );
                              }));
                            },
                            leading: Icon(
                              Icons.mail,
                              color: Color(0xff72d9f2),
                            ),
                            title: Text(
                              userMap['email'],
                              style: TextStyle(
                                color: Color(0xffffffff),
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: Icon(
                              Icons.chat,
                              color: Color(0xff72d9f2),
                            ),
                          )
                        : Container(),
                  ],
                )),
    );
  }
}
