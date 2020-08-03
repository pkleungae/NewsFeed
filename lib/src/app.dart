import 'package:NewsFeed/src/blocs/stories_provider.dart';
import 'package:flutter/material.dart';
import 'screen/news_list.dart';

// root of our application
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoriesPorvider(
        child: MaterialApp(
      title: 'News App',
      home: NewsList(),
    ));
  }
}
