import 'package:NewsFeed/src/app.dart';
import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: Text('Show some news here!'),
    );
  }
}
