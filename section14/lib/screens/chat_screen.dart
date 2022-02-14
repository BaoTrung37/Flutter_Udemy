import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (ctx, i) => Container(
          padding: EdgeInsets.all(9),
          child: Text('This Works'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            // Firebase.initializeApp();
            FirebaseFirestore.instance
                .collection('/chats/GdNtT97DBf7SsB0WNyW8/messages')
                .snapshots()
                .listen((data) {
              data.docs.map((doc) => print(doc['text'])).toString();
            });
          }),
    );
  }
}
