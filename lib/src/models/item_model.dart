import 'dart:convert'; //To convert json obj to map

class ItemModel {
  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String title;
  final int descendants;

  //constructor for from json
  ItemModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        //operator means look at the value , by defalt it is false if null value
        deleted = parsedJson['deleted'] ?? false,
        type = parsedJson['type'],
        by = parsedJson['by'] ?? '',
        time = parsedJson['time'],
        text = parsedJson['text'] ?? '',
        dead = parsedJson['dead'] ?? false,
        parent = parsedJson['parent'],
        //如果no kids return 比返個[] , 如果唔係後邊loop kids 果時, 最後係null 既話, 會有error
        kids = parsedJson['kids'] ?? [],
        url = parsedJson['url'],
        score = parsedJson['score'],
        title = parsedJson['title'],
        //sometimes it may return null value due to no comment on jobs post. so it return null
        descendants = parsedJson['descendants'] ?? 0;

  ItemModel.fromDb(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'] == 1,
        type = parsedJson['type'],
        by = parsedJson['by'],
        time = parsedJson['time'],
        text = parsedJson['text'],
        //json from db is either 1 or 0, but we need to assign true/false into model system
        dead = parsedJson['dead'] == 1,
        parent = parsedJson['parent'],
        kids = jsonDecode(parsedJson['kids']),
        url = parsedJson['url'],
        score = parsedJson['score'],
        title = parsedJson['title'],
        descendants = parsedJson['descendants'];
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "type": type,
      "by": by,
      "time": time,
      "text": text,
      "parent": parent,
      "url": url,
      "score": score,
      "title": title,
      "descendants": descendants,
      "dead": dead ? 1 : 0,
      "deleted": deleted ? 1 : 0,
      "kids": jsonEncode(kids),
    };
  }
}
