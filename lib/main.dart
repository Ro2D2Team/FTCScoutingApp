import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Screens/signUp.dart';
import 'Screens/roomsPage.dart';
import 'package:flutter/services.dart';

Map Controllers = {};
bool Wrong = false, signUpError = false, signUpErrorConfirm = false;
void initControllers() {
  Controllers['Username_log_in'] = TextEditingController();
  Controllers['Password_log_in'] = TextEditingController();
  Controllers['Password_sign_up'] = TextEditingController();
  Controllers['Username_sign_up'] = TextEditingController();
  Controllers['Team #_sign_up'] = TextEditingController();
  Controllers['Confirm Password_sign_up'] = TextEditingController();
}

void main() {
  initControllers();
  runApp(MaterialApp(home: LoginScreen()));
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

Column textFieldForm(
    String label, double myWidth, double myHeight, String Where) {
  double properHeight = 30;
  if (Where == 'sign_up') {
    properHeight = myHeight * 5 / 100;
  } else {
    properHeight = myHeight * 7 / 100;
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
          padding: EdgeInsets.fromLTRB(myWidth * 5 / 100, 0, 0, 0),
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 10,
              fontFamily: 'Sanchez',
              decoration: TextDecoration.none,
            ),
          )),
      Padding(
          padding: EdgeInsets.fromLTRB(myWidth * 5 / 100, 0, 0, 0),
          child: Container(
              height: properHeight,
              width: myWidth * 60 / 100,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(217, 217, 217, 1),
                borderRadius: BorderRadius.circular(3),
              ),
              child: TextField(
                controller: Controllers[label+'_'+Where],
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  border: InputBorder.none,
                ),
              ))),
    ],
  );
}

class _LoginScreen extends State<LoginScreen> {
  var size, myHeight, myWidth;
  // This widget is the root of your application.
  Future<void> _handleClick(context) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('Accounts');
    var username = Controllers['Username_log_in'].text;
    var password = Controllers['Password_log_in'].text;
    final snapshot = await ref.child(username+'/password').get();
    if (snapshot.exists) {
      if (snapshot.value.toString() == password) {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => roomsPage()));
      } else {
        setState(() {
          Wrong = true;
        });
      }
    } else {
      setState(() {
        Wrong = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    myHeight = size.height;
    myWidth = size.width;
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
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
                              margin: EdgeInsets.fromLTRB(
                                  0, myHeight * 10 / 100, 0, 0),
                              child: Image.asset(
                                'images/lupa_logo.jpg',
                              )),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                0, myHeight * 5 / 100, 0, 0),
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
                                      'LOG IN',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontFamily: 'Bebas Neue Regular',
                                        decoration: TextDecoration.none,
                                      ),
                                    )),
                                SizedBox(
                                  height: myHeight * 3 / 100,
                                  width: myWidth * 5 / 100,
                                ),
                                textFieldForm(
                                    'Username', myWidth, myHeight, 'log_in'),
                                SizedBox(
                                  height: myHeight * 1 / 100,
                                  width: myWidth * 5 / 100,
                                ),
                                textFieldForm(
                                    'Password', myWidth, myHeight, 'log_in'),
                                Align(
                                  alignment: Alignment(0.5, 0.5),
                                  child: Column(
                                    children: [
                                      TextButton(
                                          onPressed: () => {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            signUpScreen()))
                                              },
                                          child: const Text(
                                              'You do not have an account? Sign Up',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontFamily: 'Sanchez',
                                                decoration: TextDecoration.none,
                                              ))),
                                      Visibility(
                                          visible: Wrong,
                                          child: const Text(
                                              'Wrong password or username',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 10,
                                                fontFamily: 'Sanchez',
                                                decoration: TextDecoration.none,
                                              ))),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: myHeight * 10 / 100,
                                  width: myWidth * 5 / 100,
                                ),
                                Align(
                                    alignment: Alignment.center,
                                    child: TextButton(
                                        onPressed: () =>
                                            {_handleClick(context)},
                                        child: Image.asset(
                                          'images/arrow.jpg',
                                        ))),
                              ],
                            ),
                          )
                        ],
                      ),
                    ))));
      },
    );
  }
}
