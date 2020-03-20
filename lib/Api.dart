import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "https://pastebin.com/raw/mXSAsX18";

class API {
  static Future getNews() {
    var url = baseUrl;
    return http.get(url);
  }
}
