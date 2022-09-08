import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/List.dart';
import 'package:my_app/about.dart';
import 'package:http/http.dart' as http;

class SaveViewController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: "收集列表呀",
    //   theme: ThemeData(
    //     primarySwatch: Colors.indigo,
    //     dividerColor: Colors.black,
    //   ),
    //   home: SaveVCPage(),
    // );
    return new Scaffold(
        appBar: AppBar(
          title: Text('收藏列表'),
        ),
        body: SaveVCPage());
  }
}

class SaveVCPage extends StatefulWidget {
  @override
  State<SaveVCPage> createState() => SaveVCPageState();
}

class SaveVCPageState extends State<SaveVCPage> {
  String textToShow = '进入WebView';
  bool toggle = true;
  String jsonUrl = 'https://jsonplaceholder.typicode.com/posts';

  updateText() async {
    setState(() {
      toggle = !toggle;
      textToShow = toggle ? "进入WebView" : "进入ListView";
    });

    print("context: ${context} ${toggle}");

    if (!toggle) {
      Navigator.of(context).push(
        new MaterialPageRoute<void>(builder: (BuildContext context) {
          return DJAboutController();
        }),
      );
    } else {
      Navigator.of(context).push(
        new MaterialPageRoute<void>(builder: (BuildContext context) {
          return ListController();
        }),
      );
    }
  }

  Widget _getOneRow() {
    return CupertinoButton(
      child: Text(
        textToShow,
      ),
      onPressed: updateText,
      padding: EdgeInsets.only(left: 100, right: 100),
      color: Colors.red,
    );
  }

  Widget _getTwoRow() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          new MaterialPageRoute<void>(builder: (BuildContext context) {
            return ListController();
          }),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          '进入列表',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            backgroundColor: Colors.green,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  final int bateryValue = -1;

  static const platform = MethodChannel('samples.flutter.dev/battery');

  _bateryFetchAction() async {
    String batteryLevel;
    try {
      final int res = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $res % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
    print(batteryLevel);
  }

  Widget _getToggleChild() {
    // if (!toggle) {
    //   return Text(
    //     textToShow,
    //     style: TextStyle(fontSize: 30, color: Colors.green),
    //   );
    // }
    return ListView(
      children: <Widget>[
        _getOneRow(),
        _getTwoRow(),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/input');
            },
            child: Text('第三个BUTTON')),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/service');
            },
            child: Text('设施服务')),
        ElevatedButton(
            onPressed: () {
              _bateryFetchAction();
            },
            child: Text('获取电量')),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/page');
            },
            child: Text('联动列表')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: _getToggleChild());
  }
}
