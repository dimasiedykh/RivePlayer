import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';
import 'package:riveplayer/screens/clients_list_screen.dart';
import 'package:riveplayer/screens/password_screen.dart';
import 'package:riveplayer/screens/rive_list_screen.dart';
import 'package:riveplayer/screens/rive_player_screen.dart';
import 'package:riveplayer/utils/session_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RiveNative.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Rive Player',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  errorBuilder: (context, state) => const ClientsListScreen(),
  routes: [
    GoRoute(path: '/', builder: (context, state) => const ClientsListScreen()),
    GoRoute(
      path: '/password/:clientName',
      builder: (context, state) {
        final clientName = state.pathParameters['clientName'] ?? '';
        final redirectPath = state.uri.queryParameters['redirect'] ?? '/';
        return PasswordScreen(
          clientName: clientName,
          redirectPath: redirectPath,
        );
      },
    ),
    GoRoute(
      path: '/client/:clientName',
      redirect: (context, state) {
        final clientName = state.pathParameters['clientName'] ?? '';
        if (!SessionManager.instance.isAuthenticated(clientName)) {
          return '/password/$clientName?redirect=${state.uri.path}';
        }
        return null;
      },
      builder: (context, state) {
        final clientName = state.pathParameters['clientName'] ?? '';
        return ClientRiveScreen(clientName: clientName);
      },
    ),
    GoRoute(
      path: '/player/:clientName/:fileName',
      redirect: (context, state) {
        final clientName = state.pathParameters['clientName'] ?? '';
        if (!SessionManager.instance.isAuthenticated(clientName)) {
          return '/password/$clientName?redirect=${state.uri.path}';
        }
        return null;
      },
      builder: (context, state) {
        final clientName = state.pathParameters['clientName'] ?? '';
        final fileName = state.pathParameters['fileName'] ?? '';
        return RivePlayerScreen(clientName: clientName, fileName: fileName);
      },
    ),
  ],
);
