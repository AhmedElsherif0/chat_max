import 'package:chat_max/widgets/chat/chat_messages.dart';
import 'package:chat_max/widgets/chat/new_message.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = 'chat/screen';


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(child: ChatMessages()),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
