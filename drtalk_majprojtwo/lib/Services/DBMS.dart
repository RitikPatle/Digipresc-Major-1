import 'package:cloud_firestore/cloud_firestore.dart';

class dbms {
  final CollectionReference userlist =
      FirebaseFirestore.instance.collection('users');
  var namE, conO, clinuM, doB, eduQ, genD, regnO, eiD;

  Future<void> createUserData(String nAme, String cOno, String rEgno,
      String cLinum, String eDuq, String dOb, String gEnd, String eId) async {
    return userlist
        .add({
          'name': nAme,
          'cono': cOno,
          'clinum': cLinum,
          'dob': dOb,
          'eduq': eDuq,
          'gender': gEnd,
          'regno': rEgno,
          'eid': eId,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> getUserData() async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          print(doc["eid"]);
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
}
