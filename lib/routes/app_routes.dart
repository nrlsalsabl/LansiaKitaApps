import 'package:go_router/go_router.dart';
import 'package:health_monitor/screens/auth/login_page.dart';
import 'package:health_monitor/screens/main/main_page.dart';

import '../screens/home/homepage.dart';
import '../screens/history/history_page.dart';
import '../screens/profile/profile_page.dart';
import '../screens/settings/settings_page.dart';
import '../screens/splash/splash_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: "/",

  routes: [

    GoRoute(
      path: "/",
      builder: (_, __) => const SplashPage(),
    ),

    GoRoute(
      path: "/login",
      builder: (_, __) => const LoginPage(),
    ),

    GoRoute(
      path: "/main",
      builder: (_, __) => const MainPage(),
    ),

  ],
);