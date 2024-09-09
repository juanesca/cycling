part of 'router.dart';

final routes = [
  GoRoute(
    path: Routes.login,
    builder: (context, state) => Login(),
  ),
  GoRoute(
    path: Routes.signup,
    builder: (context, state) => const Signup(),
  ),
  GoRoute(
    path: Routes.home,
    builder: (context, state) => Layout(child: Scaffold()),
  )
];
