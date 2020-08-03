import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
//  final _storiesController = StreamController<ItemModel>();
  final _topIds = PublishSubject<List<int>>();
  final _repository = Repository();
//sink entry
//  get addStories => _storiesController.sink.add

//getter to stream
  Stream<List<int>> get topIds => _topIds.stream;

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  //retrive data from stream after processing
//  Stream<String> get stories => _storiesController.stream.transform();

  dispose() {
    _topIds.close();
  }
}
