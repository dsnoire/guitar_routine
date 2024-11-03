import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/app_bloc.dart';
import '../../sign_in/view/sign_in_page.dart';
import '../../sign_up/view/sign_up_page.dart';

class AppRouter {
  const AppRouter(this.appBloc);
  final AppBloc appBloc;

  GoRouter get router => GoRouter(
        initialLocation: '/sign-in',
        refreshListenable: GoRouterAppBlocRefreshStream(appBloc.stream),
        redirect: (context, state) {
          final isAuthenticated = appBloc.state.status == AppStatus.authenticated;

          if (isAuthenticated && state.uri.path == '/sign-in') {
            return '/home';
          }

          if (isAuthenticated && state.uri.path == '/sign-up') {
            return '/home';
          }

          if (!isAuthenticated && state.uri.path == '/home') {
            return '/sign-in';
          }

          return null;
        },
        routes: [
          GoRoute(
            path: '/sign-in',
            builder: (BuildContext context, GoRouterState state) => const SignInPage(),
          ),
          GoRoute(
            path: '/sign-up',
            builder: (BuildContext context, GoRouterState state) => const SignUpPage(),
          ),
          GoRoute(
            path: '/home',
            builder: (BuildContext context, GoRouterState state) => Scaffold(
              appBar: AppBar(
                title: const Text('Home'),
                actions: [
                  IconButton(
                    onPressed: () => context.read<AppBloc>().add(AppSignOutPressed()),
                    icon: const Icon(Icons.abc),
                  )
                ],
              ),
            ),
          )
        ],
      );
}

class GoRouterAppBlocRefreshStream extends ChangeNotifier {
  GoRouterAppBlocRefreshStream(Stream<AppState> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((appState) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
