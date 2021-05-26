import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Row(
        children: [
          Text('Loading...'),
          CircularProgressIndicator(
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ],
      )),
    );
  }
}
