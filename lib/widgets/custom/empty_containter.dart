import 'package:flutter/material.dart';

class EmptyContainer extends StatelessWidget {
  final String? text;
  final Color? color ;

  const EmptyContainer(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(text??'Something Went Wrong', style: TextStyle(fontSize: 35,color: color)),
      ),
    );
  }
}
