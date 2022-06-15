import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './message_bubble.dart';

class Messages extends StatelessWidget {
  //const Messages({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chat')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            
            final chat = chatSnapshot.data!.docs;
            
            return ListView.builder(
              reverse: true,
              itemCount: chat.length,
              itemBuilder: (context, index) => MessageBubble(
                  (chat[index].data()! as Map<String, dynamic>)['text'],
                  (chat[index].data()! as Map<String, dynamic>)['userId'] == user?.uid,
                  ValueKey(chat[index].id),
                  (chat[index].data()! as Map<String, dynamic>)['userImage'],
                  (chat[index].data()! as Map<String, dynamic>)['username']
                  ),
            );
          },
        );
      }  
}
