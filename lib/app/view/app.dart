import 'package:flutter/material.dart';

import '../../sign_in/view/sign_in_page.dart';
import '../../sign_up/view/sign_up_page.dart';
import '../app.dart';

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
