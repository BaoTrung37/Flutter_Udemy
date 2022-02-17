import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDos = chatSnapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatDos.length,
          itemBuilder: (ctx, i) => MessageBubble(
            message: chatDos[i]['text'],
            username: chatDos[i]['username'],
            isMe:
                FirebaseAuth.instance.currentUser!.uid == chatDos[i]['userId'],
            key: ValueKey(chatDos[i].id),
          ),
        );
      },
    );
  }
}
