import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // * using QuerySnapShot
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createAt', descending: true)
            .snapshots(),
        builder: (context, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final chatDos = chatSnapshot.data!.docs;
          return ListView.builder(
            reverse: true,
            itemCount: chatDos.length,
            itemBuilder: (ctx, i) =>
                MessageBubble(message: (chatDos[i].data() as dynamic)['text']),
          );
        });
  }
}
