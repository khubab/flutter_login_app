import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/repository/user_repository.dart';

/// Registration and authentication via Firebase
class FirebaseUserRepository extends UserRepository {
  const FirebaseUserRepository();

  @override
  String? get signedEmail {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return user.email;
    } else {
      return '';
    }
  }

  @override
  Future<bool> authenticate(String username, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: username, password: password);

      return true;
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      return false;
    }
  }

  @override
  Future<bool> register(String username, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: username, password: password);

      return true;
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      return false;
    }
  }

  @override
  Future<void> logOut() => FirebaseAuth.instance.signOut();
}