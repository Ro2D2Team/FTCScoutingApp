import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ftc_tracker/main.dart';

MaterialApp LScreen(myHeight, myWidth) {
  return MaterialApp(
    home: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/background_page.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
          alignment: const Alignment(0, 0),
          child: Column(children: [
            Container(
                margin: EdgeInsets.fromLTRB(0, myHeight * 30 / 100, 0, 0),
                child: Image.asset(
                  'images/lupa_logo.jpg',
                )),
            const Text(
              'FTC TRACKER',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 30,
                fontFamily: 'Bebas Neue Regular',
                decoration: TextDecoration.none,
              ),
            ),
            const Align(
                alignment: Alignment(0.6, 1),
                child: Text(
                  'by Ro2D2',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 10,
                    fontFamily: 'Sanchez',
                    decoration: TextDecoration.none,
                  ),
                ))
          ])),
    ),
  );
}

class loadingScreen extends StatelessWidget {
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false, body: LScreen(height, width));
  }
}