// Add a new route to hold the favorites.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:my_app/List.dart';
import 'package:my_app/about.dart';
import 'package:my_app/customerService.dart';
import 'package:my_app/customerService/PageController.dart';
import 'package:my_app/input.dart';
import 'package:my_app/savePage.dart';
import 'package:oktoast/oktoast.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      theme: new ThemeData(
        primaryColor: Colors.white,
        dividerColor: Colors.grey,
      ),
      home: OKToast(
        child: RandomWords(),
      ),
      routes: <String, WidgetBuilder>{
        '/a': (context) => SaveViewController(),
        '/b': (context) => DJAboutController(),
        '/c': (context) => ListController(),
        '/input': (context) => InputController(),
        '/service': (context) => CustomerServiceController(),
        '/page': (context) => TestPage(),
      },
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return const Divider();
          }
          final int index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);

    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.blue : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).pushNamed('/a');
    return;
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return SaveViewController();
          // final Iterable<ListTile> tiles = _saved.map(
          //   (WordPair pair) {
          //     return new ListTile(
          //       title: new Text(
          //         pair.asPascalCase,
          //         style: _biggerFont,
          //       ),
          //     );
          //   },
          // );
          // final List<Widget> divided = ListTile.divideTiles(
          //   context: context,
          //   tiles: tiles,
          // ).toList();
          // return new Scaffold(
          //   appBar: new AppBar(
          //     title: const Text('Saved Suggestions'),
          //   ),
          //   body: new ListView(children: divided),
          // );
        },
      ),
    );
  }
}
