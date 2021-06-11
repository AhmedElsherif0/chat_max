import 'package:chat_max/data/remote/firebase.dart';
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
      margin: const EdgeInsets.only(top: 4.0),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            decoration: const InputDecoration(labelText: 'Send Message.....'),
            onChanged: (value) {
              setState(() {
                _enteredMessage = value;
              });
            },
            controller: _controller,
          )),
          IconButton(
              icon: const Icon(Icons.send),
              color: Theme.of(context).primaryColor,
              onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage),
        ],
      ),
    );
  }

  Future<void> _sendMessage() async {
    FocusScope.of(context).unfocus();
    FireBaseHelper fireBase = FireBaseHelper();
    User? user = FirebaseAuth.instance.currentUser;
    Map? userName = await fireBase.getUserName(user!.uid);
    fireBase.addUserData(
        _enteredMessage, user.uid, userName?['name'], userName?['userImage']);
    _controller.clear();
  }
}
