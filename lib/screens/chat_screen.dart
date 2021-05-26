import 'package:chat_max/widgets/chat/chat_messages.dart';
import 'package:chat_max/widgets/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = 'chat/screen';

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Chat',style: TextStyle(color: Colors.white),),
        actions: [
          DropdownButton(
            icon: Icon(Icons.more_vert),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app, color: Colors.black),
                      SizedBox(width: 12.0),
                      Text('Logout')
                    ],
                  ),
                ),
                value: 'Logout',
              ),
            ],
            onChanged: (item) async {
              if (item == 'Logout') await FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
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
