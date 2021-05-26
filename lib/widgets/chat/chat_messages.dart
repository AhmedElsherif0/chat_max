import 'file:///C:/Users/ahmed/AndroidStudioProjects/chat_max/lib/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _currentUser(),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          return StreamBuilder(
              stream: FirebaseFirestore.instance.collection('chat')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, streamSnapShots) {
                if (streamSnapShots.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                final data = streamSnapShots.data.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: data.length,
                  itemBuilder: (ctx, index) => Container(
                    padding: EdgeInsets.all(8),
                    child: MessageBubble(
                      data.docs[index]['text'],
                      data.docs[index]['username'],
                      data.docs[index]['userImage'],
                      data.docs[index]['userId'] == _currentUser().uid,
                    ),
                  ),
                );
              });
        });
  }

  _currentUser() async {
    FirebaseAuth.instance.currentUser;
  }
}
