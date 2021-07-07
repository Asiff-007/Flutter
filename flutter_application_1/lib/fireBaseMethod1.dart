import 'package:flutter/material.dart';
import './fireBaseTrial.dart';

import 'package:firebase_core/firebase_core.dart';


class Sample extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "popcode Developer",
        home: FutureBuilder(
          future: _fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('you have an error${snapshot.error.toString()}');
              return Text("somthing wrong");
            } else if (snapshot.hasData) {
              return FireBaseTrial();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
