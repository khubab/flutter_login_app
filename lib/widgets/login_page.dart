import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_app/blocs/authentication_bloc.dart';
import 'package:flutter_login_app/blocs/login_bloc.dart';
import 'package:flutter_login_app/repository/user_repository/firebase_repository.dart';
import 'package:flutter_login_app/repository/user_repository/test_repository.dart';
import 'package:flutter_login_app/widgets/login_form.dart';
import 'package:provider/provider.dart';
import 'package:flutter_login_app/localization/app_localization.dart';

/// First widget to appear when the application starts containing
/// the [LoginForm] form.
class LoginPage extends StatelessWidget {
  const LoginPage();

  @override
  Widget build(BuildContext context) {
    /// uncomment for testing or without firebase
    // final repository = context.select((TestUserRepository u) => u);

    /// comment for testing or without firebase
    final repository = context.select((FirebaseUserRepository u) => u);

    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.localize('title')),
      ),
      body: BlocProvider<CredentialsBloc>(
        create: (context) => CredentialsBloc(
            authenticationBloc: authBloc,
            userRepository: repository
        ),
        child: const Center(
          child: LoginForm(),
        ),
      ),
    );
  }
}
