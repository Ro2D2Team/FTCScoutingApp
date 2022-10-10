import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ftc_tracker/main.dart';
import 'loadingScreen.dart';

class roomsPage extends StatefulWidget{
  @override
  _roomsPage createState() => _roomsPage();
}

class _roomsPage extends State<roomsPage>{
  var size,myHeight,myWidth;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    myHeight = size.height;
    myWidth = size.width;
    return Scaffold(
        body: MaterialApp(
            home: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/roomsFinal.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: null
            )),
        resizeToAvoidBottomInset: false);
  }
}