import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';
  final _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4.0),
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            decoration: InputDecoration(labelText: 'Send Message.....'),
            onChanged: (value) {
              setState(() {
                _enteredMessage = value;
              });
            },
            controller: _controller,
          )),
          IconButton(
              icon: Icon(Icons.send),
              color: Theme.of(context).primaryColor,
              onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage),
        ],
      ),
    );
  }

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userName = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userName['name'],
      'userImage': userName['userImage']
    });
    _controller.clear();
  }
}
