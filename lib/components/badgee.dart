// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Badgee extends StatelessWidget {
  const Badgee(
      {super.key, required this.child, required this.value, this.color});

  final Widget child;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 1,
          top: 1,
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.red),
            constraints: BoxConstraints(
              minHeight: 16,
              minWidth: 16
            ),
            child: Text(
              value,
              style: TextStyle(fontSize: 12,),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
