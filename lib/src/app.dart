import 'package:NewsFeed/src/blocs/stories_provider.dart';
import 'package:flutter/material.dart';
import 'screen/news_list.dart';
import 'screen/news_detail.dart';

// root of our application
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoriesPorvider(
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
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) {
        return NewsList();
      });
    } else {
      return MaterialPageRoute(builder: (context) {
        return NewsDetail();
      });
    }
  }
}
