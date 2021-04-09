import 'package:flutter/material.dart';
import 'package:flutter_login_app/localization/app_localization.dart';

mixin SnackMessage {
  void showMessage(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      content: Text(context.localize(text)),
    ));
  }
}