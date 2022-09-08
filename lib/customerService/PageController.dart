import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const url =
    'http://www.pptbz.com/pptpic/UploadFiles_6909/201203/2012031220134655.jpg';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  var tabTitle = [
    '页面1',
    '页面2',
    '页面3',
  ];

  _mySliverAppBar() {
    return SliverAppBar(
      title: Text('SliverPersistentHeader'),
      expandedHeight: 250,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          url,
          fit: BoxFit.cover,
        ),
        collapseMode: CollapseMode.parallax,
      ),
      // floating: _floating,
      // pinned: _pinned,
    );
  }

  _mySliverChildBuilderDelegate() {
    return SliverChildBuilderDelegate(
      (context, index) {
        return Container(
          height: 80,
          color: Colors.primaries[index % 11],
        );
      },
      childCount: 30,
    );
  }

  bool _pinned = true;
  bool _floating = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        slivers: [
          _mySliverAppBar(),
          SliverPersistentHeader(
            delegate: _MySliverPersistentHeaderDelegate(),
            // pinned: _pinned,
            // floating: _floating,
          ),
          SliverList(delegate: _mySliverChildBuilderDelegate()),
          SliverPersistentHeader(
            delegate: _MySliverPersistentHeaderDelegate(),
            pinned: _pinned,
            floating: _floating,
          ),
          SliverList(delegate: _mySliverChildBuilderDelegate()),
        ],
      ),
    );
  }
}

class _MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double _minExtent = 150;
  final double _maxExtent = 250;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => _maxExtent;

  @override
  // TODO: implement minExtent
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
