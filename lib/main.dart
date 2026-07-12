import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/health_provider.dart';

import 'routes/app_routes.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => HealthProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      routerConfig: appRouter,

      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.red),
    );
  }
}
