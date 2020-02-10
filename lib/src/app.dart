import 'package:flutter/material.dart';
import 'dart:convert';

class MyApp extends StatefulWidget {
  @override
  State createState() {
    return AppState();
  }
}

class AppState extends State<MyApp> {
  int counter = 0;

  Widget build(context) {
    return MaterialApp(
        home: Scaffold(
      body: Text('$counter'),
      appBar: AppBar(
        title: Text('lets see ${counter}'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.plus_one),
        onPressed: () {
          setState(() {
            counter++;
          });
        },
        tooltip: 'Increment',
      ),
    ));
  }
}
