import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:async/async.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:dio/dio.dart';


FirebaseUser loggedInUser;

class Preferences extends StatefulWidget {
  @override
  _PreferencesState createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
    final _fireStore = FirebaseFirestore.instance;
  final store = FirebaseStorage.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
  var storage = FlutterSecureStorage();
  Timer timer;

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

  // String user;
  final usersMemoizer = AsyncMemoizer<List<ChipsChoiceOption<String>>>();

  @override
   initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 10), (timer) async {
      // print('timer called');
      this.getCurrentUser();
    });
  }

  
  Future<void> update() async {
    setState(() {});
    // ignore: unused_local_variable
    var response = _fireStore
        .collection('users')
        .document(loggedInUser.email)
        .updateData({
      'tags': tags.toString(),
    });
  }

  Future<void> getCurrentUser() async {

    try {
     var user = _auth.currentUser;
      if (user != null) {
        setState(() {
          loggedInUser = user;
        });
            print(loggedInUser);

        print('document');
        var document = await _fireStore
            .collection('users')
            .document(loggedInUser.email)
            .get()
            .then((value) {
          setState(() {
            // tags = value.data['tags'];

            print('still working');
          });
        });
        await storage.write(key: 'tags', value: '$tags');
    
      }
    } catch (e) {
      print(e);
    }
  }
  //   addUser() async {
  //   var response =
  //       await _fireStore.collection('users').document('$_email').setData({
  //     'tags': tags,
   
  //   });
  // }


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
              onPressed: () => (
                update()
                // print(tags)
              ),
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
