part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

final class AppState extends Equatable {
  const AppState({UserModel user = UserModel.empty})
      : this._(
          status: user == UserModel.empty ? AppStatus.unauthenticated : AppStatus.authenticated,
          user: user,
        );

  const AppState._({
    required this.status,
    this.user = UserModel.empty,
  });

  final AppStatus status;
  final UserModel user;

  @override
  List<Object> get props => [status, user];
}
