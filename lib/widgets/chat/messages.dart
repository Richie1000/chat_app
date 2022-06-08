import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './message_bubble.dart';

class Messages extends StatelessWidget {
  //const Messages({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, futureSnapShot) {
        if (futureSnapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: Firestore.instance
              .collection('chat')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final chat = chatSnapshot.data.documents;
            return ListView.builder(
              reverse: true,
              itemCount: chat.length,
              itemBuilder: (context, index) => MessageBubble(
                  chat[index]['text'],
                  chat[index]['userId'] == futureSnapShot.data.uid,
                  ValueKey(chat[index].documentID),
                  chat[index]['userImage'],
                  chat[index]['username']),
            );
          },
        );
      },
    );
  }
}
