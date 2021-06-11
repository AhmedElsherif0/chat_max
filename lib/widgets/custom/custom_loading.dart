
import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
