// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:english_words/english_words.dart' as prefix0;
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sexy',
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
//  final _suggestions = <WordPair>[];
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
//    final wordPair = WordPair.random();
//    return Text(wordPair.asPascalCase);

    return Scaffold(
      appBar: AppBar(title: Text("generator")),
      body: _buildSuggestions(),
      floatingActionButton: FloatingActionButton(
        child: new Icon(Icons.add),
      ),
    );
  }

  Widget _buildSuggestions() {
    _suggestions.addAll(prefix0.generateWordPairs().take(10));
    return ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          debugPrint("i: $i");
//          if (i.isOdd) return Divider();
          final index = i ~/ 2;
//          if (index >= _suggestions.length) {
//            debugPrint("add Index: $index");
////            _suggestions.addAll(generateWordPairs().take(10));
//          }
          return _buildRow(_suggestions[i]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(title: Text(pair.asPascalCase, style: _biggerFont));
  }
}
