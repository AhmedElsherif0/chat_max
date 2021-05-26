import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String? message;
  final String? userName;
  final String? userImage;
  final bool isMe;

  const MessageBubble(this.message, this.userName, this.userImage, this.isMe);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
       children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isMe ? Colors.grey[300] : theme.accentColor),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                children: [
                  Text(
                    userName??'UnKnown',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe
                            ? Colors.black
                            : theme.accentTextTheme.headline1?.color),
                  ),
                  Text(
                    message??'Error' ,
                    style: TextStyle(
                        color: isMe
                            ? Colors.black
                            : theme.accentTextTheme.headline1?.color),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
            top: -10,
            right: isMe ? 120 : null,
            left: isMe ? null : 120,
            child: CircleAvatar(
              backgroundColor: Colors.black,
              backgroundImage: NetworkImage(userImage??''),
            )),
      ],
      clipBehavior: Clip.none,
    );
  }
}
