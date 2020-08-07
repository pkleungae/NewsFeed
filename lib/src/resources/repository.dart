import 'news_db_provider.dart';
import 'news_api_provider.dart';
import '../models/item_model.dart';

class Repository {
// having access to the db
  List<Source> sources = [
    NewsDbProvider(),
    NewsApiProvider(),
  ];

  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];

  // Iterate over sources when dbprovider
  // get fetchTopIds implemented
  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    var source;

    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }
    // 如果source 唔係cache 黎, 咁cache 就要補返item
    //就算
    for (var cache in caches) {
      //when the recieved item is not from cache db, then the db have to cache it.
      if (cache != source) {
        cache.addItem(item);
      }
    }

    return item;
  }

  //刪掉caches 的內容
  clearCache() async {
    for (var cache in caches) {
      await cache.clear();
    }
  }
}

abstract class Source {
  //fetch a list of top id
  Future<List<int>> fetchTopIds();
  //return item according to the id
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
  Future<int> clear();
}
