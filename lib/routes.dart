import 'package:flutter/material.dart';
import 'package:flutter_login_app/widgets/init_firebase_widget.dart';

class RouteGenerator {
  const RouteGenerator._();

  static const homePage = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute<InitFirebaseWidget>(
          builder: (_) => InitFirebaseWidget(),
        );

      default:
        throw RouteException('Route not found');
    }
  }
}

class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}