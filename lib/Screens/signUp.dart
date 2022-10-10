import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ftc_tracker/main.dart';
import 'loadingScreen.dart';
import 'roomsPage.dart';

class signUpScreen extends StatefulWidget {
@override
_signUpScreen createState() => _signUpScreen();
}

class _signUpScreen extends State<signUpScreen> {
  var size, myHeight, myWidth;
  Future<void> _handleSignUpClick(context) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('Accounts');
    var username = Controllers['Username_sign_up'].text;
    var password = Controllers['Password_sign_up'].text;
    var confirm_password = Controllers['Confirm Password_sign_up'].text;

    final usernameSnapshot = await ref.child(username).get();
    if (usernameSnapshot.exists) {
      setState((){signUpError = true; signUpError = false;});
    }
    else
    {
      if (confirm_password != password)
      {
        setState((){signUpError = false; signUpErrorConfirm = true; });
      }
      else
      {
        await ref.child(username).set({
          'password' : password,
          'Team' : Controllers['Team #_sign_up'].text,
        });
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => roomsPage()));
      }
    }
  }

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
                    image: AssetImage("images/background_page.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: const Alignment(0, 0),
                  child: Column(
                    children: [
                      Container(
                          margin:
                          EdgeInsets.fromLTRB(0, myHeight * 10 / 100, 0, 0),
                          child: Image.asset(
                            'images/lupa_logo.jpg',
                          )),
                      Container(
                        margin:
                        EdgeInsets.fromLTRB(0, myHeight * 5 / 100, 0, 0),
                        height: myHeight * 55 / 100,
                        width: myWidth * 70 / 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 10,
                              blurRadius: 5,
                              offset: const Offset(
                                  9, 9), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'SIGN UP',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontFamily: 'Bebas Neue Regular',
                                    decoration: TextDecoration.none,
                                  ),
                                )),
                            SizedBox(
                              height: myHeight * 1 / 100,
                              width: myWidth * 5 / 100,
                            ),
                            textFieldForm(
                                'Username', myWidth, myHeight, 'sign_up'),
                            Visibility(
                                visible: signUpError,
                                child: const Text('Username already taken',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 10,
                                      fontFamily: 'Sanchez',
                                      decoration: TextDecoration.none,
                                    ))),
                            SizedBox(
                              height: myHeight * 1 / 100,
                              width: myWidth * 5 / 100,
                            ),
                            textFieldForm(
                                'Team #', myWidth, myHeight, 'sign_up'),
                            SizedBox(
                              height: myHeight * 1 / 100,
                              width: myWidth * 5 / 100,
                            ),
                            textFieldForm(
                                'Password', myWidth, myHeight, 'sign_up'),
                            SizedBox(
                              height: myHeight * 1 / 100,
                              width: myWidth * 5 / 100,
                            ),
                            textFieldForm('Confirm Password', myWidth, myHeight,
                                'sign_up'),
                            Visibility(
                                visible: signUpErrorConfirm,
                                child: const Text('Username already taken',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 10,
                                      fontFamily: 'Sanchez',
                                      decoration: TextDecoration.none,
                                    ))),
                            SizedBox(
                              height: myHeight * 1 / 100,
                              width: myWidth * 5 / 100,
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: TextButton(
                                    onPressed: () =>
                                    {_handleSignUpClick(context)},
                                    child: Image.asset(
                                      'images/arrow.jpg',
                                    )))
                          ],
                        ),
                      )
                    ],
                  ),
                ))),
        resizeToAvoidBottomInset: false);
  }
}