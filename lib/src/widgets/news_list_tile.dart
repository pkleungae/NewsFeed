import 'package:NewsFeed/src/blocs/stories_provider.dart';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/stories_provider.dart';
import 'dart:async';
import 'loadingContainer.dart';

class NewsListTile extends StatelessWidget {
  //Tile need to know which id it need to responsible for
  final int itemId;

  NewsListTile({this.itemId});

  Widget build(context) {
    final bloc = StoriesPorvider.of(context);
    //bloc.fetchItem(itemId);
    return StreamBuilder(
        stream: bloc.items,
        builder:
            (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
          if (!snapshot.hasData) {
            return Text('Stream is lodaing');
          }
          return FutureBuilder(
              future: snapshot.data[itemId],
              builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
                if (!itemSnapshot.hasData) {
                  //future 未返果陣show 呢個
                  return LoadingContainer();
                  // return Text('Still loading $itemId');
                }
                return buildTile(context, itemSnapshot.data);
              });
        });
  }

  Widget buildTile(BuildContext context, ItemModel item) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () {
            // Navigator.push(context, Route('/${item.id}');
            //當被按時, navigator就傳送 item id 比on generatorroute
            Navigator.pushNamed(context, '/${item.id}');
            print('{$item.id} was tapped ');
          },
          title: Text(item.title),
          subtitle: Text('${item.score} points'),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.comment),
              Text('${item.descendants}'),
            ],
          ),
        ),
        Divider(
          height: 8.0,
        ),
      ],
    );
  }
}
