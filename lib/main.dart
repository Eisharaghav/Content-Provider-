import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          Icon(Icons.settings, color: Colors.black),
          SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                height: 400,
                child: GridView.count(
                  scrollDirection: Axis.horizontal,
                  crossAxisCount: 3,
                  children: List.generate(12, (index) {
                    return Container(
                      child: Card(
                        elevation: 3.0,
                        color: Colors.white,
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "SAP",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
