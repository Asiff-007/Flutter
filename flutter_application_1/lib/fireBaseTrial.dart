import 'package:flutter/cupertino.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class FireBaseTrial extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
      appBar: AppBar(title: Text('FRIENDS LIST'),),
      body:StreamBuilder (
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
          return ListTile(
            
              leading:Text(user['Name']),
              title:Text('${user['Age']}'),
           
          );
        }
        );
          }
        }
        ,)
      
      
       
    );
  }
}