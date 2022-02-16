import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flutter chat'),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
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
