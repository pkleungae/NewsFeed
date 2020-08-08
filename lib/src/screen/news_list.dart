import 'package:NewsFeed/src/app.dart';
import 'package:NewsFeed/src/blocs/stories_bloc.dart';
import 'package:NewsFeed/src/blocs/stories_provider.dart';
import 'package:NewsFeed/src/models/item_model.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../widgets/news_list_tile.dart';
import '../widgets/refresh.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //用static method 拿下bloc, 把其pass 去不同widget
    final bloc = StoriesPorvider.of(context);

    bloc.fetchTopIds();
    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    //把WIDGET LISTEN於bloc 內的topid stream
    //當收到更新時, builder 會更新, snapshot 會睇stream 的output
    return StreamBuilder(
        stream: bloc.topIds,
        builder: (context, AsyncSnapshot<List<int>> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          //以refreah 包起 List view, 當list swipe 向上時, 重新更新db  , 刪下所有cache 記錄
          return Refresh(
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, int index) {
                //do this when user scoll to that point
                bloc.fetchItem(snapshot.data[index]);
                // return Text('${snapshot.data[index]}');
                //this block will initate and create in list as widget. but the action code wont be excuted first (try to explain in this way to explain the sequence of listen and fetching problem)
                return NewsListTile(itemId: snapshot.data[index]);
              },
            ),
          );
        });
  }
  //   return ListView.builder(
  //     //create 1000 block
  //     itemCount: 1000,
  //     //the for loop  logic code inside
  //     itemBuilder: (context, int index) {
  //       return FutureBuilder(
  //           future: getFuture(),
  //           builder: (context, snapshot) {
  //             return snapshot.hasData
  //                 ? Text('I\'m visible $index')
  //                 : Text('The future hasnt resolved yet');
  //           });
  //     },
  //   );
  // }

  // getFuture() {
  //   return Future.delayed(
  //     Duration(seconds: 2),
  //     () => 'hi',
  //   );
  // }
}
