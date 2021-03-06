import 'package:NewsFeed/src/blocs/comments_provider.dart';
import 'package:NewsFeed/src/models/item_model.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../widgets/comment.dart';

class NewsDetail extends StatelessWidget {
  // 同News Detail communicate, 必須有paramenter 去hold item id
  final int itemId;

  NewsDetail({this.itemId});
  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: buildBody(bloc),
    );
  }

  buildBody(CommentsBloc bloc) {
    // watch the stream
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading');
        }
        final itemFuture = snapshot.data[itemId];

        return FutureBuilder(
          future: itemFuture,
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Text('Loading');
            }
            // 第一個ITEM 為TOP LEVEL STORY 的ID
            return buildList(itemSnapshot.data, snapshot.data);
          },
        );
      },
    );
  }

// 第一個ITEM 為TOP LEVEL STORY 的ID , 所以detail's title 可以從那邊找
// 第二個itemMap為build 起 comment 的所需要resource.
  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final children = <Widget>[];
    children.add(buildTitle(item));
    // 拿出top level 的comments
    final commentsList = item.kids.map((kidId) {
      // 將每一個都用comments封好 再放入一個list 以供list view 用
      return Comment(
        itemId: kidId,
        itemMap: itemMap,
        depth: 0,
      );
    }).toList();

    children.addAll(commentsList);

    return ListView(
      children: children,
    );
  }

  // helper function
  Widget buildTitle(ItemModel item) {
    return Container(
      margin: EdgeInsets.all(10.0),
      alignment: Alignment.topCenter,
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
