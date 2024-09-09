import 'package:app/core/utils/providers.dart';
import 'package:app/core/utils/route.constants.dart';
import 'package:app/presentation/pages/login.dart';
import 'package:app/presentation/pages/signup.dart';
import 'package:app/presentation/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

part 'routes.dart';

final _key = GlobalKey<NavigatorState>(debugLabel: 'rootRouter');

final routerProvider = Provider(
  (ref) {
    final authenticated = ref.watch(authStateProvider);
    return GoRouter(
      navigatorKey: _key,
      initialLocation: Routes.login,
      routes: [...routes],
    );
  },
);
