import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:async/async.dart';
// import 'package:dio/dio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'preferences',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Preferences(),
    );
  }
}

class Preferences extends StatefulWidget {
  @override
  _PreferencesState createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  int tag = 1;
  List<String> tags = [];

  List<String> options = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'wre',
    'Tech',
    'Science',
  ];

  String user;
  final usersMemoizer = AsyncMemoizer<List<ChipsChoiceOption<String>>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text('Select Your Interest'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () => _about(context),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Content(
            title: 'CAT1',
            child: ChipsChoice<String>.multiple(
              value: tags,
              options: ChipsChoiceOption.listFrom<String, String>(
                source: options,
                value: (i, v) => v,
                label: (i, v) => v,
              ),
              onChanged: (val) => setState(() => tags = val),
              isWrapped: true,
            ),
          ),
          Center(
            child: FlatButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              // onPressed: ,
              child: Text(
                "Submit",
                style: TextStyle(
                  fontSize: 16.0,
                  // fontFamily: "WorkSansSemiBold"
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Content extends StatelessWidget {
  final String title;
  final Widget child;

  Content({
    Key key,
    @required this.title,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            color: Colors.black12,
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.blueGrey, fontWeight: FontWeight.w500),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

void _about(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(
              'Preferences',
              style: Theme.of(context)
                  .textTheme
                  .headline
                  .copyWith(color: Colors.black87),
            ),
            trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Select your Field of Interest, which you want to see later and dont forget to Submit :) .',
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(color: Colors.black54),
                  ),
                  Container(height: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
