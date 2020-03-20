class News {
  String name = "";
  String link = "";
  String flag = "";

  News(String name, String link, String flag) {
    this.name = name;
    this.link = link;
    this.flag = flag;
  }

  News.fromJson(Map json)
      : name = json['name'],
        link = json['link'],
        flag = json['flag'];

  Map toJson() {
    return {'name': name, 'link': link, 'flag': flag};
  }
}