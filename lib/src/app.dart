import 'package:NewsFeed/src/blocs/stories_provider.dart';
import 'package:flutter/material.dart';
import 'screen/news_list.dart';
import 'screen/news_detail.dart';
import 'blocs/comments_provider.dart';

// root of our application
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesPorvider(
        child: MaterialApp(
          title: 'News App',
          onGenerateRoute: routes,
          // }
          //   if (settings.name == '/') {
          //     return MaterialPageRoute(builder: (context) {
          //       return NewsList();
          //     });
          //   } else {
          //     return MaterialPageRoute(builder: (context) {
          //       return NewsDetail();
          //     });
          //   }
        ),
      ),
    );
    // TODO: implement build
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) {
        return NewsList();
      });
    } else {
      return MaterialPageRoute(builder: (context) {
        //get access to the comments Bloc
        final commentsBloc = CommentsProvider.of(context);
        // 將/{id} 的/ 拿走, 再轉做integer
        final itemId = int.parse(settings.name.replaceFirst('/', ''));
        commentsBloc.fetchItemWithComments(itemId);
        return NewsDetail(
          itemId: itemId,
        );
      });
    }
  }
}
