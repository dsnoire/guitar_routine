part of 'app_bloc.dart';

sealed class AppEvent {
  const AppEvent();
}

final class AppUserSubscriptionRequested extends AppEvent {}

final class AppSignOutPressed extends AppEvent {}
