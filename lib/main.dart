import 'package:InfoApp/pages/homepage.dart';
import 'package:InfoApp/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'pages/preferences.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var storage = FlutterSecureStorage();
  bool isLogged = false;
  bool doneLoading = false;

  checkForLoggedInUser() async {
    var _bool = await storage.read(key: 'isLogged');
    var _email = await storage.read(key: 'email');
    var _pass = await storage.read(key: 'pass');
    if (_bool == 'true') {
      print(_bool);
      setState(() {
        isLogged = true;
      });
    }
    setState(() {
      doneLoading = true;
    });
  }

  @override
  void initState() {
    checkForLoggedInUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'cont',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
//     home: doneLoading == true
//         ? isLogged == false ? LoginPage() : BottomNavigation()
//         : BottomNavigation(),
      home: doneLoading == true ? isLogged == false ? LoginPage() : HomePage() : LoginPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/preferences' : (context) => Preferences(),
      },
    );
  }
}
