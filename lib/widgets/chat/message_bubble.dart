import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  // const MessageBubble({ Key? key }) : super(key: key);

  final String message;
  final bool isMe;
  final Key key;
  final String userImage;
  final String userName;

  MessageBubble(
      this.message, this.isMe, this.key, this.userImage, this.userName);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft:
                        !isMe ? Radius.circular(0) : Radius.circular(12),
                    bottomRight:
                        isMe ? Radius.circular(0) : Radius.circular(12)),
              ),
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Column(
                children: [
                  Text(
                    userName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(message,
                      style: TextStyle(
                          color: isMe
                              ? Colors.black
                              : Theme.of(context)
                                  .accentTextTheme
                                  .headline1
                                  .color)),
                ],
              ),
            ),
          ],
        ),
        //if (!isMe)
        Positioned(
            top: 0,
            left: isMe ? null : 130,
            right: isMe ? 130 : null,
            child: CircleAvatar(
              backgroundImage: NetworkImage(userImage),
            ))
      ],
      overflow: Overflow.visible,
    );
  }
}
