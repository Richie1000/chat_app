import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  //const ChatScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ChatApp"),
      ),
      body: StreamBuilder(
        //snapshot is used to return a stream which means its going to emit new values when data changes
        stream: Firestore.instance
            .collection('chats/WgRTtjTJQMZAp89gunqh/messages')
            .snapshots(),
        builder: (context, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data.documents;
          return ListView.builder(
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.all(5),
              child: Text(documents[index]['text']),
            ),
            itemCount: documents.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Firestore.instance
                .collection('chats/WgRTtjTJQMZAp89gunqh/messages')
                .add({'text': 'New Message added'});
          }),
    );
  }
}
