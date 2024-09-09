import 'package:flutter/material.dart';

final q = MediaQueryData.fromView(
    WidgetsBinding.instance.platformDispatcher.views.first);

extension Viewport on num {
  get sw => this * q.size.width / 100;

  get sh => this * q.size.height / 100;
}
