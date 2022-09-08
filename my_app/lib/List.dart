import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: "列表展示",
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //     dividerColor: Colors.grey,
    //   ),
    //   home: ListPage(),
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text('列表展示'),
      ),
      body: ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListPageState();
  }
}

class ListPageState extends State<ListPage> {
  // 列表
  List<Widget> _widgets = [];

  @override
  initState() {
    super.initState();
    for (int i = 0; i < 5; i++) {
      _widgets.add(_getRow(i));
    }
  }

  addRows() {
    setState(() {
      var cur = _widgets.length;
      // _widgets = List.from(_widgets);
      for (int i = cur; i < cur + 5; i++) {
        _widgets.add(_getRow(i));
      }
      print("addRows ${cur} ${_widgets.length}");
    });
  }

  Widget _getRow(int i) {
    return GestureDetector(
      onTap: () {
        print("clicked row ${i}");
        addRows();
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          "Row ${i}",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: i % 2 == 0 ? Colors.blue : Colors.red,
            fontSize: 17,
            fontWeight: FontWeight.bold,
            height: 2,
            backgroundColor:
                i % 2 == 0 ? Colors.lightBlueAccent : Colors.lightGreenAccent,
          ),
          selectionColor: Colors.lightGreen,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _widgets.length,
      itemBuilder: (context, row) {
        return _getRow(row);
      },
    );
    return ListView(
      children: _widgets,
    );
  }
}
