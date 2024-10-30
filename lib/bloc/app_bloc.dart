import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(AppState(user: authenticationRepository.currentUser)) {
    on<AppUserSubscriptionRequested>(_onAppUserSubscriptionRequested);
    on<AppSignOutPressed>(_onAppLogoutPressed);
  }

  final AuthenticationRepository _authenticationRepository;

  Future<void> _onAppUserSubscriptionRequested(
    AppUserSubscriptionRequested event,
    Emitter<AppState> emit,
  ) {
    return emit.onEach(
      _authenticationRepository.user,
      onData: (user) => emit(AppState(user: user)),
      onError: addError,
    );
  }

  void _onAppLogoutPressed(
    AppSignOutPressed event,
    Emitter<AppState> emit,
  ) {
    _authenticationRepository.signOut();
  }
}
