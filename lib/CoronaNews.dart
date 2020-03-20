import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:CoronaWashNews/News.dart';
import 'package:CoronaWashNews/Api.dart';

import 'package:url_launcher/url_launcher.dart';

//import 'package:CoronaWashNews/main.dart';

final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

class Album {
  final int userId;
  final int id;
  final String title;

  Album({this.userId, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class MyCoronaNewsWidget extends StatefulWidget {
  MyCoronaNewsWidget({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyCoronaNewsWidgetState createState() => _MyCoronaNewsWidgetState();
}


class _MyCoronaNewsWidgetState extends State<MyCoronaNewsWidget> {
  var _news = new List<News>();

  Future<String> _getNews() async {
    API.getNews().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        _news = list.map((model) => News.fromJson(model)).toList();
      });
      return 'success';
    });
    return 'success';
  }

  _clickedNews(int newsid) {
      var news = _news[newsid];
      launch(news.link);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _getNews();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(153,102,51,0),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
    /*      actions: [
            IconButton (
                icon: new Image.asset('icons/flags/png/gb.png', package: 'country_icons'),
                onPressed: () {
                  setState(() {
                    _localLanguage = "gb";
                    _getNews();
                  });
                }
            ),
            IconButton (
                icon: new Image.asset('icons/flags/png/de.png', package: 'country_icons'),
                onPressed: () {
                  setState(() {
                    _localLanguage = "de";
                    _getNews();

                  });
                }
            ),
          ]*/
      ),
      body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _getNews,
          child:  ListView.builder(
          itemCount: _news.length,
          itemBuilder: (context, index) {
              return ListTile(
                leading: new Image.asset(
                    'icons/flags/png/' + _news[index].flag + '.png',
                    package: 'country_icons'),
                title: Text(_news[index].name, style: Theme
                    .of(context)
                    .textTheme
                    .headline6),
                onTap: () {
                  _clickedNews(index);
                },
              );
          },
      )
      )
    );
  }
}

/*
            FutureBuilder<Album>(
              future: futureAlbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column (
                    children: [
                      Text(snapshot.data.toString()),
                      Text(snapshot.data.title),
                      Text("hi"),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),

                        RaisedButton (
              textColor: Colors.white,
              color: Colors.grey,
              child: Text("Corona News"),
              onPressed: () {
                Navigator.push(
                  context,
                    MaterialPageRoute(builder: (BuildContext context) { return MyHomePage(title: 'hiu'); })
                );
              },
            ),
 */