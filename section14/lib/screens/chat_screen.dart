import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // * using QuerySnapShot
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('/chats/GdNtT97DBf7SsB0WNyW8/messages')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            // return ListView(
            //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
            //     final data = document.data()! as Map<String, dynamic>;
            //     return Text(data['text']as String);
            //   }).toList(),
            // );
            final document = snapshot.data!.docs;
            return ListView.builder(
              itemCount: document.length,
              itemBuilder: (ctx, i) =>
                  Text((document[i].data() as dynamic)['text']),
            );
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            FirebaseFirestore.instance
                .collection('/chats/GdNtT97DBf7SsB0WNyW8/messages')
                .add({
              'text': 'This was added by clicking the button!',
            });
          }),
    );
  }
}
