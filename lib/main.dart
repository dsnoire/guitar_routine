import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_routine/app/bloc_observer.dart';
import 'firebase_options.dart';

import 'app/view/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    App(
      authenticationRepository: AuthenticationRepository(),
    ),
  );
}
