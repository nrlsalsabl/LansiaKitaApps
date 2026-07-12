import 'package:go_router/go_router.dart';

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
      builder: (context, state) => const SplashPage(),
    ),

    GoRoute(
      path: "/home",
      builder: (context, state) => const HomePage(),
    ),

    GoRoute(
      path: "/history",
      builder: (context, state) => const HistoryPage(),
    ),

    GoRoute(
      path: "/profile",
      builder: (context, state) => const ProfilePage(),
    ),

    GoRoute(
      path: "/settings",
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);