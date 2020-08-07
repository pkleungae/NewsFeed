import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';

class Refresh extends StatelessWidget {
  final child;

  Refresh({this.child});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesPorvider.of(context);
    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await bloc.clearCache();
        await bloc.fetchTopIds();
      },
    );
  }
}
