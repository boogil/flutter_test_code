import 'dart:convert';

import 'package:flutter/material.dart';
import 'src/app.dart';
import 'dart:async';

void main() {
  runApp(MyApp());

  var rawJson = '{"url": "http://blah.jpg", "id": 1}';

  // json parser
  var paredJson = json.decode(rawJson);
  var imageModel = new ImageModel(paredJson['id'], paredJson['url']);

  print(imageModel);

  // 비동기 함수
  print('1. start to fetch data');
  get('http://weasds.com').then((data) {
    print(data);
  });
  print('3. finish call to fetch the data');
}

class ImageModel {
  int id;
  String url;

  ImageModel(this.id, this.url);

  String toString() {
    return '$id, $url';
  }
}

Future<String> get(String url) {
  return new Future.delayed(new Duration(seconds: 3), () {
    return '2. I Got a data!';
  });
}
