import 'package:app/infrastructure/di/http.dart';
import 'package:app/infrastructure/di/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await CHttp().init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final router = ref.watch(routerProvider);
      return MaterialApp.router(
        // routerDelegate: router.routerDelegate,
        // routeInformationParser: router.routeInformationParser,
        // routeInformationProvider: router.routeInformationProvider,
        routerConfig: router,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
      );
    });
  }
}
