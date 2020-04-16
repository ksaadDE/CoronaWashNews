import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:CoronaWashNews/CoronaNews.dart';
import 'package:url_launcher/url_launcher.dart';

var rndNumber = new Random();
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corona Wash your Hands & News',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
      ),
      home: MyHomePage(title: 'Wash your Hands!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counterStartTime = 60;
  int _counter = 60;
  bool _counterRunning = false;

  String get timeString {
    return (_counter).toString();
  }

  String _message = "";

  var funnySentences = [
    "Just a bit more!",
    "Wash your hands!",
    "Go!",
    "More!!",
    "Just a few Seconds left!",
    "Don't worry! Your Hands will be clean in a few Seconds",
    "Don't forget the Finger Tips",
    "Don't forget between the Fingers and the Wrist",
    "What do you want to do after you're finished?",
    "Clean Hands are sooo nice!",
  ];

  void switchCountDown(){
    setState(() {
      if(!_counterRunning){
        // Start CD
        _counter = counterStartTime;
        _counterRunning = true;
        _message = "";
        print("Start");
        _Tick();
      } else {
        // Stop IT
        _counterRunning = false;
        _counter = 0;
        _message = "Press the Button to start the Timer!";
        print("Ende");
      }
    });
  }
  void _Tick(){
    setState(() {
      if (_counter == counterStartTime && _counterRunning){
        _message = "OK Lets go!";
      }
      if (_counter <= 0 && _counterRunning) {
        _message = "Finished!!!";
        _counterRunning = false;
        return;
      }
      if (!_counterRunning) { _message="ttt"; return; }
        Timer(Duration(seconds: 1), () {
          if (_counter - 1 >= 0) {
            _counter--;
            if (_counter % 3 == 1) {
              _message = funnySentences[rndNumber.nextInt(funnySentences.length)];
            }
            _Tick();
          } else {
            _counterRunning = false;
          }
        });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    setState(() {
      if(_message.length == 0)_message = "Press Button to start the Timer!";
    });


    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Color.fromARGB(153,102,51,0),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),*/
      appBar: AppBar(
          backgroundColor: Colors.green,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          actions: [
            IconButton (
                icon: Icon(Icons.chrome_reader_mode, color: Colors.red),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) { return MyCoronaNewsWidget(title: 'Corona News'); })
                  );
                }
            ),
            IconButton (
              icon: Icon(Icons.info, color: Colors.blue),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      title: new Text("Informationen"),
                      content: new Text("For further informations look at the Github Repository\nCreated by Karim Saad & Tom Asmus - All Rights Reserved\nTrademarks, Property, Images of other contributors are not affected."),
                      actions: <Widget>[
                        // usually buttons at the bottom of the dialog
                        new FlatButton(
                          child: new Text("Github Repository"),
                          onPressed: () {
                            launch("https://github.com/ksaadDE/CoronaWashNews");
                          },
                        ), new FlatButton(
                          child: new Text("OK"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            )
          ]
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text (
              _message,
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              '$timeString',
              style: Theme.of(context).textTheme.headline4,
            ),
            FloatingActionButton(
              heroTag: "btn1",
              onPressed: switchCountDown,
              tooltip: 'Increment',
              child: Icon(Icons.access_alarm),
            )
          ],
        ),
      ),
    );
  }
}
