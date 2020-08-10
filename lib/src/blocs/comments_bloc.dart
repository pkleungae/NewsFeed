import '../models/item_model.dart';
import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import 'dart:async';

class CommentsBloc {
  final _repository = Repository();
//stream Controller (rx libray)
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  // streams

  Stream<Map<int, Future<ItemModel>>> get itemWithComments =>
      _commentsOutput.stream;

  // sink
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

//set up for transformer
  CommentsBloc() {
    _commentsFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }

  _commentsTransformer() {
    //input is integer , outputer is Future<ItemModel>

    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
      (cache, int id, index) {
        cache[id] = _repository.fetchItem(id);
        //只要future is returned and resolved, 就行
        cache[id].then((ItemModel item) {
          item.kids.forEach((kidId) => fetchItemWithComments(kidId));
        });
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}
