
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: _fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('you have an error${snapshot.error.toString()}');
              return Text("somthing wrong");
            } else if (snapshot.hasData) {
              return MyHomePage();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
        //
        );
  }
}

class MyHomePage extends StatelessWidget {
  

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

   @override
  Widget build(BuildContext context) {
    
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      
      child:StreamBuilder (
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder:(context, snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: Text('loading'),);

          }
          else{
            return ListView.builder(
        itemCount: (snapshot.data! as QuerySnapshot).docs.length,
        itemBuilder: (BuildContext context,int index){
          DocumentSnapshot user=(snapshot.data! as QuerySnapshot).docs[index];
          return Container(
            height: 400,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black
              ),
            ),
            child: Column(children: <Widget>[
              Text(user['Name']),
              Text('${user['Age']}'),
            ],),
          );
        }
        );
          }
        }
        ,)
      
      
       
    );
  }
  
}
