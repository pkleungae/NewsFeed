import 'dart:convert';
import 'package:NewsFeed/src/resources/news_api_provider.dart';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('Fetch topids returns a list of ids', () async {
    final newsApi = NewsApiProvider();

    newsApi.client = MockClient((request) async {
      return await Response(json.encode([1, 2, 3, 4]), 200);
    });

    final ids = await newsApi.fetchTopIds();

    expect(ids, [1, 2, 3, 4]);
  });

  test('Fetch item', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      final jsonMap = {'id': 123};
      return Response(json.encode(jsonMap), 200);
    });

    final item = await newsApi.fetchItem(999);
    expect(item.id, 123);
  });
}
