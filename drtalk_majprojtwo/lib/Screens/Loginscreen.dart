import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drtalk_majprojtwo/Services/Authentication.dart';

// ignore: camel_case_types
class loginScreen extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

// ignore: camel_case_types
class _loginScreenState extends State<loginScreen> {
  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .where('eid', isEqualTo: currUsr)
        .get()
        .then(
      (QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach(
          (doc) {
            eiD = doc['eid'];
            usrName = doc['name'];
          },
        );
      },
    );
  }

  Authentication authentication = Authentication();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var currUsr, eiD, usrName;

  Future navigator() async {
    final User currentUser = _firebaseAuth.currentUser;
    final uid = currentUser.uid;
    currUsr = uid;
    // ignore: unrelated_type_equality_checks
    if (eiD == uid) {
      Navigator.pushReplacementNamed(
        context,
        '/home',
        arguments: {'UserName': usrName},
      );
    } else {
      Navigator.pushReplacementNamed(
        context,
        '/userdata',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 100,
                    ),
                    child: Text(
                      'Hello User',
                      style: TextStyle(
                        color: Color(0xFFB40284A),
                        fontSize: 28,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(32),
                    child: Text(
                      'Please login using your Google Account and then fill all the required information. And feel free to use the app.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFB40284A),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                child: Center(
                  child: Image.asset(
                    'assets/logo.png',
                    height: 300,
                    width: 300,
                    color: Color(0xFFB40284A),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    child: GestureDetector(
                      onTap: () async {
                        await authentication.googleSignIn().then((value) async {
                          await navigator();
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(32, 32, 32, 10),
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFB40284A),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () async {
                        await authentication.googleSignOut();
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(32, 0, 32, 32),
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFB40284A),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            'Reset Firebase User',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
