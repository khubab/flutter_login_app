import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/routes/home_page.dart';

class InitFirebaseWidget extends StatefulWidget {
  const InitFirebaseWidget();

  @override
  _InitFirebaseWidgetState createState() => _InitFirebaseWidgetState();
}

class _InitFirebaseWidgetState extends State<InitFirebaseWidget> {
  late final Future<FirebaseApp> _initialization;

  @override
  void initState() {
    super.initState();

    _initialization = Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error initializing firebase'),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {



          return const Center(
            child: const HomePage(),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}