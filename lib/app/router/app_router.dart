import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../sign_in/view/sign_in_page.dart';
import '../../sign_up/view/sign_up_page.dart';

abstract class AppRouter {
  static final router = GoRouter(
    initialLocation: '/sign-in',
    routes: [
      GoRoute(
        path: '/sign-in',
        builder: (BuildContext context, GoRouterState state) => const SignInPage(),
      ),
      GoRoute(
        path: '/sign-up',
        builder: (BuildContext context, GoRouterState state) => const SignUpPage(),
      ),
    ],
  );
}
