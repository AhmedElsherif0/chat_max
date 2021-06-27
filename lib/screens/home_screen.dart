import 'package:chat_max/screens/chat_screen.dart';
import 'package:chat_max/widgets/custom/empty_containter.dart';
import 'package:chat_max/widgets/custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'home_screen';

  @override
  Widget build(BuildContext context) {
    List<Widget> _tabsList = const [
      Text('Chats'),
      Text('Status'),
      Text('Calls')
    ];
    final textStyle = const TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);
    return DefaultTabController(
      length: _tabsList.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ChatX'),
          actions: [
            _buildDropDownButton(context),
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorPadding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            labelStyle: textStyle,
            labelColor: Colors.white,
            labelPadding: const EdgeInsets.symmetric(vertical: 4),
            tabs: _tabsList,
          ),
          flexibleSpace: GradientAppBar(),
        ),
        body: TabBarView(
          children: [
            ChatScreen(),
            EmptyContainer('Status', Colors.lightBlue),
            EmptyContainer('Calls', Colors.lightBlue)
          ],
        ),
      ),
    );
  }

  DropdownButton _buildDropDownButton(BuildContext context) {
    return DropdownButton(
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      items: [
        DropdownMenuItem(
          value: 'Logout',
          child: Row(
            children: const [
              Icon(Icons.exit_to_app, color: Colors.black),
              SizedBox(width: 12.0),
              Text('Logout')
            ],
          ),
        ),
      ],
      onChanged: (item) async {
        if (item == 'Logout') await FirebaseAuth.instance.signOut();
      },
    );
  }
}
