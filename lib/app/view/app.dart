import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_routine/app/router/app_router.dart';

import '../../bloc/app_bloc.dart';
import '../theme/app_theme.dart';

class App extends StatelessWidget {
  const App({
    required AuthenticationRepository authenticationRepository,
    super.key,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (context) => AppBloc(authenticationRepository: _authenticationRepository)
          ..add(
            AppUserSubscriptionRequested(),
          ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Guitar Routine',
      theme: AppTheme.theme,
      routerConfig: AppRouter.router,
    );
  }
}
