import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/customerService/servicePage.dart';
import 'package:oktoast/oktoast.dart';

class CustomerServiceController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置页面'),
      ),
      body: CustomerServicePage(),
    );
  }
}

class CustomerServicePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CustomerServiceState();
  }
}

typedef IntCallBlock = Function(int);

class CustomerServiceTitle extends StatelessWidget {
  const CustomerServiceTitle(
      {required this.title, required this.clickBlock, required this.selected});

  final String title;
  final VoidCallback clickBlock;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        clickBlock();
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: selected ? FontWeight.bold : FontWeight.w400,
            color: selected ? Colors.black : Colors.black54,
          ),
        ),
      ),
    );
  }
}

class CustomerServiceState extends State<CustomerServicePage> {
  final String fetchUrl =
      "https://o2osit.dejiplaza.com/dj-open-api/app/systemConfig?key=store_navigation_bar_title";

  List<dynamic> dataList = [];
  int selectIdx = 0;

  _fetchData() async {
    try {
      var res = await Dio().get(fetchUrl);
      var jsonData = res.data['data'];
      Map<String, dynamic> dataObj = json.decode(jsonData);
      setState(() {
        selectIdx = dataObj['customerService']['defaultIndex'] as int;
        dataList = dataObj['customerService']['data'];
        print("========设置属性成功=========");
      });
      print("========获取设施列表成功=========");
    } catch (e) {
      print("network error: $e");
    }
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  List<Widget> _getTabWigets() {
    List<Widget> t = [];
    for (int i = 0; i < dataList.length; i++) {
      t.add(CustomerServiceTitle(
        title: dataList[i]['tabName'],
        clickBlock: () {
          this.setState(() {
            selectIdx = i;
          });
        },
        selected: i == selectIdx,
      ));
    }
    return t;
  }

  @override
  Widget build(BuildContext context) {
    if (dataList.isEmpty) {
      return Center(
        child: Text("请求数据中..."),
      );
    }
    return ListView(
      children: <Widget>[
        LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _getTabWigets(),
            ),
          );
        }),
        ServiceController(data: dataList[selectIdx]),
      ],
    );
  }
}
