import 'dart:async';
import 'package:http/http.dart' as http;

var Urls = {
  'global': 'https://pastebin.com/raw/RuAfZ8T8',
  'en': 'https://pastebin.com/raw/mXSAsX18',
  'de': 'https://pastebin.com/raw/S0vbMbWS',
};

class API {
  static Future getNews(String lang) {
    try {
      var url = Urls[lang];
      if (url.length == 0) {
        // if url[i] == ""
        return null;
      }
      return http.get(url);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
