import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drtalk_majprojtwo/Services/DBMS.dart';
import 'package:drtalk_majprojtwo/Services/Authentication.dart';

// ignore: camel_case_types
class aboutUserScreen extends StatefulWidget {
  @override
  _aboutUserScreenState createState() => _aboutUserScreenState();
}

// ignore: camel_case_types
class _aboutUserScreenState extends State<aboutUserScreen> {
  Authentication authentication = Authentication();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final registerKey = GlobalKey<FormState>();

  // ignore: non_constant_identifier_names
  int _SelectedRadio;

  // ignore: non_constant_identifier_names
  var _Name,
      // ignore: non_constant_identifier_names
      _Cono,
      // ignore: non_constant_identifier_names
      _Regno,
      // ignore: non_constant_identifier_names
      _Clinum,
      // ignore: non_constant_identifier_names
      _Eduq,
      // ignore: non_constant_identifier_names
      _Eid,
      // ignore: non_constant_identifier_names
      _Gender = "",
      // ignore: non_constant_identifier_names
      _Dob = "D.O.B(dd/mm/yyyy)",
      eiD,
      usrName;

  @override
  void initState() {
    super.initState();
    _SelectedRadio = 0;
    final User currentUser = _firebaseAuth.currentUser;
    final uid = currentUser.uid;
    _Eid = uid;
    FirebaseFirestore.instance
        .collection('users')
        .where('eid', isEqualTo: _Eid)
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

  setSelectedRadio(int val) {
    setState(() {
      _SelectedRadio = val;
      if (_SelectedRadio == 1) {
        _Gender = "Male";
      } else if (_SelectedRadio == 2) {
        _Gender = "Female";
      } else {
        _Gender = "Others";
      }
    });
  }

  DateTime _date = DateTime.now();

  Future<Null> selectDate(BuildContext context) async {
    DateTime _datePicker = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1974),
      lastDate: DateTime(2030),
    );
    if (_datePicker != null && _datePicker != _date) {
      setState(() {
        _date = _datePicker;
        var _ifdate = _date.toString();
        _ifdate = _ifdate.substring(0, 10);
        // ignore: non_constant_identifier_names
        var ListDate = _ifdate.split('-');
        var y = ListDate[0];
        var m = ListDate[1];
        var d = ListDate[2];
        var _fdate = '$d/$m/$y';
        _Dob = _fdate;
      });
    }
  }

  // ignore: non_constant_identifier_names
  void _SaveUserData() async {
    registerKey.currentState.save();
    await dbms().createUserData(
        _Name, _Cono, _Regno, _Clinum, _Eduq, _Dob, _Gender, _Eid);
    registerKey.currentState.reset();
    setState(() {
      _SelectedRadio = 0;
      _Dob = "D.O.B(dd/mm/yyyy)";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: registerKey,
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
                          margin: EdgeInsets.only(left: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            border: Border.all(
                              color: Color(0xFFB40284A),
                              width: 1,
                            ),
                          ),
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            onSaved: (input) => _Name = input,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Full Name",
                              prefixIcon: Icon(Icons.drive_file_rename_outline),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(6, 10, 0, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            border: Border.all(
                              color: Color(0xFFB40284A),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "  Gender:",
                                style: TextStyle(
                                  color: Color(0xFFB40284A),
                                  fontSize: 18,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "  Male",
                                    style: TextStyle(
                                      color: Color(0xFFB40284A),
                                      fontSize: 16,
                                    ),
                                  ),
                                  Radio(
                                    value: 1,
                                    groupValue: _SelectedRadio,
                                    activeColor: Color(0xFFB40284A),
                                    onChanged: (val) {
                                      setSelectedRadio(val);
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Female",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFFB40284A),
                                    ),
                                  ),
                                  Radio(
                                    value: 2,
                                    groupValue: _SelectedRadio,
                                    activeColor: Color(0xFFB40284A),
                                    onChanged: (val) {
                                      setSelectedRadio(val);
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Others",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFFB40284A),
                                    ),
                                  ),
                                  Radio(
                                    value: 3,
                                    groupValue: _SelectedRadio,
                                    activeColor: Color(0xFFB40284A),
                                    onChanged: (val) {
                                      setSelectedRadio(val);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 6),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Color(0xFFB40284A),
                                    width: 1,
                                  ),
                                ),
                                padding: EdgeInsets.only(left: 10),
                                child: MaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      selectDate(context);
                                    });
                                  },
                                  child: Text(
                                    "$_Dob",
                                    style: TextStyle(
                                      color: Color(0xFFB40284A),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Color(0xFFB40284A),
                                      width: 1,
                                    ),
                                  ),
                                  padding: EdgeInsets.only(left: 10),
                                  child: TextFormField(
                                    onSaved: (input) => _Cono = input,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Contact Number",
                                      prefixIcon: Icon(Icons.phone),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(6, 10, 0, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            border: Border.all(
                              color: Color(0xFFB40284A),
                              width: 1,
                            ),
                          ),
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            onSaved: (input) => _Regno = input,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Registration No",
                              prefixIcon: Icon(Icons.app_registration),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(6, 10, 0, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            border: Border.all(
                              color: Color(0xFFB40284A),
                              width: 1,
                            ),
                          ),
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            onSaved: (input) => _Clinum = input,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Clinic Name",
                              prefixIcon: Icon(Icons.medical_services),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(6, 10, 0, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            border: Border.all(
                              color: Color(0xFFB40284A),
                              width: 1,
                            ),
                          ),
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            onSaved: (input) => _Eduq = input,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Education Qualifications",
                              prefixIcon: Icon(Icons.article),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: MaterialButton(
                            onPressed: () {
                              _SaveUserData();
                              final User currentUser =
                                  _firebaseAuth.currentUser;
                              final uid = currentUser.uid;
                              _Eid = uid;
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .where('eid', isEqualTo: _Eid)
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
                              ).then((value) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/home',
                                  arguments: {
                                    'UserName': usrName,
                                  },
                                );
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xFFB40284A),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Save Information",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
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
                                '/home',
                                arguments: {
                                  'UserName': usrName,
                                },
                              );
                            },
                            child: Text(
                              'Back',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFFB40284A),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
