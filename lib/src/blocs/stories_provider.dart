import 'stories_bloc.dart';
import 'package:flutter/material.dart';

class StoriesPorvider extends InheritedWidget {
  final StoriesBloc bloc;

  StoriesPorvider({Key key, Widget child})
      : bloc = StoriesBloc(),
        super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static StoriesBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StoriesPorvider>().bloc;
  }
}
