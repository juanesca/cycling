import 'package:app/core/utils/size.extension.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double _size;

  Logo({super.key, double? size}) : _size = size ?? 10.sw;

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints.loose(Size.square(_size)),
        color: Colors.teal,
        child: Image.asset(
          'assets/cycling.png',
          colorBlendMode: BlendMode.dstATop,
          fit: BoxFit.cover,
        ));
  }
}
