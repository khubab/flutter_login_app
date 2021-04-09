import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_app/blocs/authentication_bloc/bloc.dart';
import 'package:flutter_login_app/blocs/authentication_bloc/events.dart';
import 'package:flutter_login_app/blocs/login_bloc/events.dart';
import 'package:flutter_login_app/blocs/login_bloc/states.dart';
import 'package:flutter_login_app/repository/user_repository.dart';

/// Manages the login state of the app
class CredentialsBloc extends Bloc<CredentialsEvent, CredentialsState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;
  CredentialsBloc({
    required this.authenticationBloc,
    required this.userRepository
  }) : super(CredentialsInitial());

  @override
  Stream<CredentialsState> mapEventToState(CredentialsEvent event) async* {
    if (event is LoginButtonPressed) {
      yield* _loginPressed(event);
    }

    if (event is RegisterButtonPressed) {
      yield* _registerPressed(event);
    }
  }

  Stream<CredentialsState> _loginPressed(CredentialsEvent event) async* {
    yield CredentialsLoginLoading();

    try {
      final success =
          await userRepository.authenticate(event.username, event.password);

      if (success) {
        authenticationBloc.add(const LoggedIn());
        yield CredentialsInitial();
      } else {
        yield CredentialsLoginFailure();
      }
    } on FirebaseException {
      yield CredentialsLoginFailure();
    }
  }

  Stream<CredentialsState> _registerPressed(CredentialsEvent event) async* {
    yield CredentialsRegisterLoading();

    try {
      final success =
      await userRepository.register(event.username, event.password);

      if (success) {
        authenticationBloc.add(const LoggedIn());
        yield CredentialsInitial();
      } else {
        yield CredentialsRegisterFailure();
      }
    } on FirebaseException {
      yield CredentialsRegisterFailure();
    }
  }
}