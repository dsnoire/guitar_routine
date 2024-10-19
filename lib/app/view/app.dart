import 'package:flutter/material.dart';

import '../../sign_in/view/sign_in_page.dart';
import '../theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guitar Routine',
      theme: AppTheme.theme,
      home: const SignInPage(),
    );
  }
}
