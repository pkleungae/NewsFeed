import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
//  final _storiesController = StreamController<ItemModel>();
  final _topIds = PublishSubject<List<int>>();
  final _repository = Repository();

  //special stream controller , then keep the recent stream value
  //final _items = BehaviorSubject<int>();
  //which would be wired up to tile stream builder, so that stream builder can be updated
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  //which would send date items itemsOutput
  final _itemsOutputFetcher = PublishSubject<int>();

  //streams that pass to stream builder to list , expose it to outside world
  //Stream<Map<int, Future<ItemModel>>> items;
  // Stream<Future<ItemModel>> items;

//sink entry
//  get addStories => _storiesController.sink.add

//getter to the stream //list view need it in future builder
  Stream<List<int>> get topIds => _topIds.stream;
// //getter to stream of item controller
//   get items => _items.stream.transform(_itemsTransformer());
  Stream<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  StoriesBloc() {
    //config the stream.
    //每當 _items stream 有sink 加入時, stream 要行的process
    // items = _items.stream.transform(_itemsTransformer());

    _itemsOutputFetcher.stream
        .transform(_itemsTransformer())
        .pipe(_itemsOutput);
  }
// getter to sinks of item controller
  Function(int) get fetchItem => _itemsOutputFetcher.sink.add;

  fetchTopIds() async {
    // await 一定要講, 因為如果唔係下邊引用ref 做parameter時, type都係future, 但future 內的data才是正確type.
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      // call back function
      //1 argument: cache
      //2 arguemnt:  stream value coming in
      //3:
      (Map<int, Future<ItemModel>> cache, int id, int index) {
        //put the key value into the map
        print(index);
        cache[id] = _repository.fetchItem(id);
        // return the Cache
        return cache;
      }, // the map we initate
      <int, Future<ItemModel>>{},
    );
  }

  clearCache() {
    //need to return future in advanced to repositiory , so that that await can be indicator to know when it is completed.
    return _repository.clearCache();
  }
  //retrive data from stream after processing
//  Stream<String> get stories => _storiesController.stream.transform();

  dispose() {
    _topIds.close();
    _itemsOutput.close();
    _itemsOutputFetcher.close();
  }
}
