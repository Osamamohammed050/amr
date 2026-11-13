import 'package:go_router/go_router.dart';

import '../../features/home/screens/home_screen.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: false,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/portfolio',
        name: 'portfolio',
        builder: (context, state) => const HomeScreen(initialSection: 'portfolio'),
      ),
      GoRoute(
        path: '/about',
        name: 'about',
        builder: (context, state) => const HomeScreen(initialSection: 'about'),
      ),
      GoRoute(
        path: '/services',
        name: 'services',
        builder: (context, state) => const HomeScreen(initialSection: 'services'),
      ),
      GoRoute(
        path: '/contact',
        name: 'contact',
        builder: (context, state) => const HomeScreen(initialSection: 'contact'),
      ),
      GoRoute(
        path: '/book-session',
        name: 'book-session',
        builder: (context, state) => const HomeScreen(initialSection: 'book-session'),
      ),
    ],
  );
}
