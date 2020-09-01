import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'New App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final store = FirebaseStorage.instance;
    var storage = FlutterSecureStorage();

  final _auth = FirebaseAuth.instance;
  List itemList = ["College", "Jobs", "Extras", "Courses","X","Y","Zl","A"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: Colors.white,
        title: Text(
          "Homepage",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        titleSpacing: 5.0,
        leading: Icon(Icons.clear_all, color: Colors.black),
        actions: <Widget>[
          Icon(Icons.account_circle, color: Colors.black),
          SizedBox(width: 10),
          IconButton(icon: Icon(Icons.exit_to_app,color: Colors.red,), onPressed: () async {
                                        await _auth.signOut();
                                        await storage.write(
                                            key: 'isLogged', value: 'false');
                                        await storage.write(
                                            key: 'profileData', value: 'false');
        Navigator.pushReplacementNamed(context, '/login');
                                      }),
          Icon(Icons.settings, color: Colors.black),
          SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(10.0),
                  childAspectRatio: 1.8,
                  children: itemList.map((item) {
                    return Container(
                      child: Card(
                        elevation: 3.0,
                        color: Colors.white,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Top Searched",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                height: 100,
                child: GridView.count(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  crossAxisCount: 1,
                  padding: EdgeInsets.all(10.0),
                  childAspectRatio: 0.45,
                  children: itemList.map((item) {
                    return Container(
                      child: Card(
                        elevation: 3.0,
                        color: Colors.white,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
