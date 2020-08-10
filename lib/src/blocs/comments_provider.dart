import 'package:flutter/material.dart';
import 'comments_bloc.dart';
export 'comments_bloc.dart';

class CommentsProvider extends InheritedWidget {
  final CommentsBloc bloc;

  CommentsProvider({Key key, Widget child})
      //基本set up
      : bloc = CommentsBloc(),
        super(key: key, child: child);

  //define overide function
  @override
  bool updateShouldNotify(_) => true;

  //define overide function
  static CommentsBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CommentsProvider>().bloc;
  }
}
