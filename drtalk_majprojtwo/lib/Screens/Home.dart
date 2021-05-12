import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:drtalk_majprojtwo/Services/Authentication.dart';

// ignore: camel_case_types
class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

// ignore: camel_case_types
class _homeState extends State<home> {
  Authentication authentication = Authentication();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  var namE, conO, clinuM, doB, eduQ, genD, regnO, eiD, currUsr;
  var data = {};

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    try {
      final User currentUser = _firebaseAuth.currentUser;
      final uid = currentUser.uid;
      currUsr = uid;
      FirebaseFirestore.instance
          .collection('users')
          .where('eid', isEqualTo: currUsr)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          namE = doc['name'];
          conO = doc['cono'];
          clinuM = doc['clinum'];
          doB = doc['dob'];
          eduQ = doc['eduq'];
          genD = doc['gender'];
          regnO = doc['regno'];
          eiD = doc['eid'];
          print([namE, conO, clinuM, doB, eduQ, genD, regnO, eiD]);
        });
      });
    } catch (e) {
      print("Failed to get user: ${e.toString()}");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: SpeedDial(
          overlayColor: Colors.white10,
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: Color(0xFFB40284A),
          foregroundColor: Colors.white,
          children: [
            SpeedDialChild(
              label: "Log Out",
              onTap: () async {
                await authentication.googleSignOut().whenComplete(() {
                  Navigator.pushReplacementNamed(
                    context,
                    '/login',
                  );
                });
              },
              child: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              backgroundColor: Color(0xFFB40284A),
            ),
            SpeedDialChild(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/newpresc',
                );
              },
              label: "Create New Prescription",
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: Color(0xFFB40284A),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFB40284A),
                        Color(0xFFB5f3670),
                      ],
                      end: Alignment.bottomCenter,
                      begin: Alignment.topCenter,
                    ),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(90)),
                  ),
                  child: Center(
                    child: Image.asset("assets/logo.png"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Text(
                          'Hello Dr. ${data['UserName']}',
                          style: TextStyle(
                            color: Color(0xFFB40284A),
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 10, 0, 0),
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                          border: Border.all(
                            color: Color(0xFFB40284A),
                            width: 1,
                          ),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              '/userdata',
                            );
                          },
                          child: Text(
                            "Edit User's Information",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFB40284A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          'Previous Records',
                          style: TextStyle(
                            color: Color(0xFFB40284A),
                            fontSize: 24,
                          ),
                        ),
                      ),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Prescriptions')
                            .where('Dr', isEqualTo: currUsr)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData == false) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            height: 350,
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: snapshot.data.docs.map((e) {
                                return Container(
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Color(0xFFB40284A),
                                    ),
                                  ),
                                  child: ExpansionTile(
                                    title: Text(
                                      "Name: ${e['Name']} \nTime: ${e['Time']}\nDate: ${e['Date']}",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Divider(
                                              color: Colors.black,
                                              thickness: 1,
                                              indent: 20,
                                              endIndent: 20,
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  30, 0, 0, 0),
                                              child: Text(
                                                "Gender: ${e['Gender']}",
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  30, 0, 0, 0),
                                              child: Text(
                                                "Age: ${e['Age']}",
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              color: Colors.black,
                                              thickness: 1,
                                              indent: 20,
                                              endIndent: 20,
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  30, 0, 0, 0),
                                              child: Text(
                                                "Symptoms:",
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  120, 0, 0, 0),
                                              child: Text(
                                                "${e['Sympt']}",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              color: Colors.black,
                                              thickness: 1,
                                              indent: 20,
                                              endIndent: 20,
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  30, 0, 0, 0),
                                              child: Text(
                                                "Daignosis:",
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  120, 0, 0, 0),
                                              child: Text(
                                                "${e['Diag']}",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              color: Colors.black,
                                              thickness: 1,
                                              indent: 20,
                                              endIndent: 20,
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  30, 0, 0, 0),
                                              child: Text(
                                                "Prescription:",
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  120, 0, 0, 0),
                                              child: Text(
                                                "${e['Presc']}",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              color: Colors.black,
                                              thickness: 1,
                                              indent: 20,
                                              endIndent: 20,
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  30, 0, 0, 0),
                                              child: Text(
                                                "Advice:",
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  120, 0, 0, 15),
                                              child: Text(
                                                "${e['Adv']}",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                    trailing: Icon(Icons.menu),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
