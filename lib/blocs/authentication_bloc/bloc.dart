import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_app/blocs/authentication_bloc/events.dart';
import 'package:flutter_login_app/blocs/authentication_bloc/states.dart';
import 'package:flutter_login_app/repository/user_repository.dart';

/// Manages the authentication state of the app
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  AuthenticationBloc(this.userRepository) : super(AuthenticationInit());

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is LoggedIn) {
      yield AuthenticationSuccess();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.logOut();
      yield AuthenticationRevoked();
    }
  }
}