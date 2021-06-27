import "package:flutter/material.dart";

class GradientAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [ theme.accentColor,theme.primaryColor],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.5, 0.0),
              stops: [0.1, 1.0],
              tileMode: TileMode.clamp)),
    );
  }
}
