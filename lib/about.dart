

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DJAboutController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('关于德基'),
      ),
      body: AboutPage(),
    );
  }
}

class AboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AboutState();
  }
}

class AboutState extends State<AboutPage> {

  String loadUrl = "https://www.baidu.com";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WebView(
      initialUrl: loadUrl,
      javascriptMode: JavascriptMode.unrestricted,
    );

    return Text("fnaklsndf;ansdkfaksdfkmafnas");
  }
}