// @dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'utilities/constants.dart';

class ChatRoom extends StatelessWidget {
  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": FirebaseAuth.instance.currentUser.email,
        "message": _message.text,
        "time": FieldValue.serverTimestamp(),
      };
      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .add(messages);

      _message.clear();
    } else {
      print('Enter some text');
    }
  }

  final Map<String, dynamic> userMap;
  final String chatRoomId;

  ChatRoom({this.userMap, this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            userMap['email'],
            style: TextStyle(fontSize: 14, fontFamily: 'SpartanMB'),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          height: size.height / 1.25,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('chatroom')
                      .doc(chatRoomId)
                      .collection('chats')
                      .orderBy('time', descending: false)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.data != null) {
                      return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> map =
                                snapshot.data.docs[index].data();
                            return messages(size, map);
                          });
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              Container(
                height: size.height / 30,
                width: size.width,
                alignment: Alignment.center,
                child: Container(
                  height: size.height / 12,
                  width: size.width / 1.1,
                  decoration: kMessageContainerDecoration,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: size.height / 12,
                        width: size.width / 1.5,
                        child: TextField(
                          controller: _message,
                          decoration: kMessageTextFieldDecoration,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            onSendMessage();
                          },
                          icon: Icon(
                            Icons.send,
                            size: 22,
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget messages(Size size, Map<String, dynamic> map) {
  final isMe = FirebaseAuth.instance.currentUser;
  return Container(
    padding: EdgeInsetsDirectional.all(10),
    width: size.width,
    alignment: map['sendby'] == isMe.email
        ? Alignment.centerRight
        : Alignment.centerLeft,
    child: Material(
      elevation: 5.0,
      borderRadius: map['sendby'] == isMe.email
          ? BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))
          : BorderRadius.only(
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
      color:
          map['sendby'] == isMe.email ? Colors.lightBlueAccent : Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Text(
          map['message'],
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: map['sendby'] == isMe.email ? Colors.white : Colors.black),
        ),
      ),
    ),
  );
}
