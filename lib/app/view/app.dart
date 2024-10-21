import 'package:flutter/material.dart';
import 'package:guitar_routine/app/router/app_router.dart';

import '../theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Guitar Routine',
      theme: AppTheme.theme,
      routerConfig: AppRouter.router,
    );
  }
}
