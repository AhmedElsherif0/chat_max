import 'file:///C:/Users/ahmed/AndroidStudioProjects/chat_max/lib/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  final Stream<QuerySnapshot> _messageStream = FirebaseFirestore.instance
      .collection('chat')
      .orderBy('createdAt', descending: true)
      .snapshots(includeMetadataChanges: true);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _currentUser(),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          return StreamBuilder(
              stream: _messageStream,
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapShots) {
                if (streamSnapShots.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                final data = streamSnapShots.data!.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: data.length,
                  itemBuilder: (ctx, index) => Container(
                    padding: EdgeInsets.all(8),
                    child: MessageBubble(
                      data[index]['text'],
                      data[index]['username'],
                      data[index]['userImage'],
                      data[index]['userId'] ==
                          FirebaseAuth.instance.currentUser?.uid,
                    ),
                  ),
                );
              });
        });
  }

  _currentUser() async {}
}
