import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:guitar_routine/bloc/app_bloc.dart';

import '../../sign_in/view/sign_in_page.dart';
import '../../sign_up/view/sign_up_page.dart';

abstract class AppRouter {
  static final router = GoRouter(
    redirect: (context, state) {
      final appStatus = context.read<AppBloc>().state.status;
      if (appStatus == AppStatus.authenticated) {
        return '/home';
      } else if (appStatus == AppStatus.unauthenticated) {
        return '/sign-in';
      }

      return null;
    },
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
