import 'package:flutter/material.dart';
import 'screen/news_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'News App',
      home: NewsList(),
    );
  }
}
