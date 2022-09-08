import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServiceController extends StatelessWidget {
  const ServiceController({required this.data});

  final Map<String, dynamic> data;

  List<Widget> _getWidgets() {
    List<Widget> t = [];

    // 添加头部
    t.add(Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(
            colors: [Color(0xFFFFFFFF), Color(0xFFF3E9C6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 10,
              spreadRadius: 2,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image(
                width: 100,
                height: 100,
                image: NetworkImage(data['icon']),
              ),
              Container(
                width: 10,
              ),
              Text(
                data['longName'],
                style: TextStyle(
                  color: Color(0xFF4A4A4A),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Divider(),
          Text(
            data['desc'],
            style: TextStyle(
              color: Color(0xFF4A4A4A),
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    ));

    var list = data['list'] as List;
    list.forEach((sectionItem) {
      t.add(Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Text(
          sectionItem['sectionTitle'],
          style: TextStyle(
            color: Color(0xFF4A4A4A),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
      var rows = sectionItem['rows'] as List;
      rows.forEach((rowItem) {
        var showPic = rowItem['showPic'] as List;
        var title = rowItem['title'] as String;
        t.add(GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            print("row tap: ${rowItem}");
          },
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Color(0xFF4A4A4A),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    'images/icon_service_location.png',
                    width: 24,
                    height: 24,
                  ),
                )
              ],
            ),
          ),
        ));
        t.add(Divider());
      });
    });

    return t;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _getWidgets(),
      ),
    );
  }
}
