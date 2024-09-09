import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  final Widget child;

  const Layout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Cycling',
            style: TextStyle(
                color: Colors.teal[600],
                fontWeight: FontWeight.w600,
                fontSize: 22),
          ),
        ),
        body: child,
    );
  }
}
