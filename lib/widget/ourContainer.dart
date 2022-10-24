import 'package:flutter/material.dart';

class ShadowContainer extends StatelessWidget {
  const ShadowContainer({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
              spreadRadius: 1.0,
              offset: Offset(4.0, 4.0))
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: child,
    );
  }
}
