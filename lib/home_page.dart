import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static String tag='home-page';
  @override
  Widget build(BuildContext context) {
    final alucard=Hero(
      tag:'hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircleAvatar(
          radius: 72.0,
          backgroundColor: Colors.transparent,
          backgroundImage:new  AssetImage("assets/logins.png"),
          ),
      ),
    );
    
    final welcome=Padding(
      padding: EdgeInsets.all(8.8),
      child: Text(
        'Welcome ömer',
        style: TextStyle(fontSize: 28.0,color:Colors.white,),
        ),
    );

    final lorem=Padding(
      padding: EdgeInsets.all(8.8),
      child: Text(
        'ömer merhsbs  berdaerda lorem ipsum dolor and color.white blue shirt with have got.lorem ipsum dolor and color.white blue shirt with have got.lorem ipsum dolor and color.white blue shirt with have got.lorem ipsum dolor and color.white blue shirt with have got.lorem ipsum dolor and color.white blue shirt with have got.lorem ipsum dolor and color.white blue shirt with have got.you have got a blue coats and black shoes',
        style: TextStyle(fontSize: 16.0,color:Colors.white,),
        ),
    );
    final body=Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.blue,
          Colors.lightBlueAccent,
        ])
      ),
      child: Column(children: <Widget>[alucard,welcome,lorem],
    ),
    );

  return Scaffold(
    body:body ,
  );
  }
}