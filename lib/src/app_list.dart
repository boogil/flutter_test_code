import 'package:flutter/material.dart';
import 'package:flutter_app/main_list.dart';
import 'dart:convert';
import 'package:http/http.dart' show get;
import 'package:flutter_app/model/image_model.dart';
import 'package:flutter_app/widget/image_list.dart';

class App extends StatefulWidget {
  @override
  State createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int counter = 0;
  List<ImageModel> images = [];

  void fetchImage() async {
    counter++;
    var response =
        await get('https://jsonplaceholder.typicode.com/photos/$counter');

    var imageModel = ImageModel.fromJson(json.decode(response.body));

    print(response.body);
    setState(() {
      images.add(imageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: ImageList(images),
      appBar: AppBar(title: Text("이미지 리스트 보기")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: fetchImage,
      ),
    ));
  }
}
