import 'package:flutter/material.dart';
import 'package:health_monitor/providers/auth_provider.dart';
import 'package:health_monitor/theme/app_theme.dart';
import 'package:provider/provider.dart';

import 'providers/health_provider.dart';

import 'routes/app_routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),

        ChangeNotifierProvider(create: (_) => HealthProvider()),
      ],

      child: MaterialApp.router(routerConfig: appRouter, theme: AppTheme.light),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(theme: AppTheme.light, routerConfig: appRouter);
  }
}
