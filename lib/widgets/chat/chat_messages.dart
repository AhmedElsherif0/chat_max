import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'message_bubble.dart';

class ChatMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _currentUser(),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            const Center(child: CircularProgressIndicator());
          }
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chat')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapShots) {
                if (streamSnapShots.connectionState ==
                    ConnectionState.waiting) {
                  const Center(child: CircularProgressIndicator());
                }
                if (!streamSnapShots.hasData) {
                  return Center(
                      child:
                          Container(child: const Text('Something Went Wrong')));
                }
                final data = streamSnapShots.data?.docs;
                return _listBuilder(data!);
              });
        });
  }

  Future _currentUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  ListView _listBuilder(List<QueryDocumentSnapshot<Object?>> data) {
    return ListView.builder(
      reverse: true,
      itemCount: data.length,
      itemBuilder: (ctx, index) => Container(
        padding: const EdgeInsets.all(8),
        child: MessageBubble(
          data[index]['text'],
          data[index]['username'],
          data[index]['userImage'],
          data[index]['userId'] == FirebaseAuth.instance.currentUser?.uid,
        ),
      ),
    );
  }
}
