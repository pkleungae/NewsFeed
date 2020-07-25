import 'package:NewsFeed/src/resources/repository.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';

class NewsApiProvider implements Source {
  Client client = Client();
  final _root = 'https://hacker-news.firebaseio.com/v0';

  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$_root/topstories.json');
    //parse it into usable json data
    final ids = json.decode(response.body);

    return ids.cast<int>(); //to give a view to dart, it is a list of integer
  }

  fetchItem(int id) async {
    final response = await client.get('$_root/item/$id.json');
    final parsedJson = json.decode(response.body);
    return ItemModel.fromJson(parsedJson);
  }
}
