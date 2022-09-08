import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class InputController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('输入测试'),
      ),
      body: InputPage(),
    );
  }
}

class InputPageActionButton extends StatelessWidget {
  const InputPageActionButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(onPressed: onPressed, child: Text('点一下试试'), style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.red,
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        decoration: TextDecoration.underline,
      ),
      padding: EdgeInsets.all(10),
    ));
  }
}

class InputPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InputState();
  }
}

class InputState extends State<InputPage> {
  var myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  _taped() {
    print("_taped");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16),
          child: TextField(
            controller: myController,
          ),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            myController.text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.green,
            ),
            textDirection: TextDirection.ltr,
          ),
        ),
        Divider(),
        InputPageActionButton(onPressed: _taped),
        Divider(),
      ],
    );
  }
}
