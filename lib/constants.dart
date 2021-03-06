import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF004D40);
const kPrimaryLightColor = Color(0xFFB2DF2DB);

void displayDialog(context, title, text) => showDialog(
  context: context,
  builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.only(top: 10.0),
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          heightFactor: 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                text,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 20),
                child: Text(
                  'Please try again',
                  style: TextStyle(color: Colors.redAccent),
                ),
              )
            ],
          ),
        ),
      )),
);
