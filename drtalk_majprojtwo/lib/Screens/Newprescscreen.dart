import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: camel_case_types
class newPresc extends StatefulWidget {
  @override
  _newPrescState createState() => _newPrescState();
}

// ignore: camel_case_types
class _newPrescState extends State<newPresc> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final _firestore = FirebaseFirestore.instance;
    final saveKey = GlobalKey<FormState>();
    var _Name, _Gend, _Age, _Sympt, _Diag, _Presc, _Adv;
    void _savePresc() async {
      final User user = await _auth.currentUser;
      final _uid = user.uid;

      var now = new DateTime.now();
      var Dformatter = new DateFormat('dd/MM/yyyy');
      String Dateofpresc = Dformatter.format(now);
      var Tformatter = new DateFormat('HH:mm:s');
      String Timeofpresc = Tformatter.format(now);
      saveKey.currentState.save();
      _firestore.collection('Prescriptions').add({
        'Dr': _uid,
        'Age': _Age,
        'Sympt': _Sympt,
        'Name': _Name,
        'Diag': _Diag,
        'Gender': _Gend,
        'Presc': _Presc,
        'Adv': _Adv,
        'Date': Dateofpresc,
        'Time': Timeofpresc,
      }).then((value) {
        Share.share(
          "Name: $_Name\nAge: $_Age\nGender: $_Gend\n\nSymptoms:\n$_Sympt\n\nDaiagnosis:\n$_Diag\n\nPrescription:\n$_Presc\n\nAdvice:\n$_Adv",
          subject: "Prescription",
        );
        Navigator.pop(context);
      }).catchError((e) {
        print("Could not register the user $_Name : $e");
      });
      saveKey.currentState.reset();
    }

    //_Name,_Gender,_Age,_Sympt,_Diagnosis,_Presc,_Advice

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: saveKey,
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                      onSaved: (input) => _Gend = input,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Gender",
                        prefixIcon: Icon(Icons.app_registration),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                      onSaved: (input) => _Age = input,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Age",
                        prefixIcon: Icon(Icons.date_range),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xFFB40284A),
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.only(left: 10),
                    child: TextField(
                      onChanged: (input) => _Sympt = input,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Symptoms",
                        prefixIcon: Icon(Icons.edit_outlined),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xFFB40284A),
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.only(left: 10),
                    child: TextField(
                      onChanged: (input) => _Diag = input,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Diagnosis",
                        prefixIcon: Icon(Icons.edit),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xFFB40284A),
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.only(left: 10),
                    child: TextField(
                      onChanged: (input) => _Presc = input,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Prescription",
                        prefixIcon: Icon(Icons.edit),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xFFB40284A),
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.only(left: 10),
                    child: TextField(
                      onChanged: (input) => _Adv = input,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Advice",
                        prefixIcon: Icon(Icons.edit),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(80, 10, 0, 0),
                        child: MaterialButton(
                          onPressed: () => _savePresc(),
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Color(0xFFB40284A),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Share",
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
                            Navigator.pop(context);
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
