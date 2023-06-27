import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

Future<String> firebase_login(String id) async {
  try {
    var documentSnapshot =
        await FirebaseFirestore.instance.collection("user").doc(id).get();
    if (documentSnapshot.exists) {
      var data = documentSnapshot.data();
      if (data != null && data.containsKey("password")) {
        return data["password"].toString();
      } else {
        return "no";
      }
    } else {
      return "no";
    }
  } catch (e) {
    return "no";
  }
}

Future<String> addBmiData(
    String bmi, String height, String weight, String id) async {
  var db = FirebaseFirestore.instance;
  final data = <String, dynamic>{
    "bmi": bmi,
    "height": height,
    "weight": weight,
    "id": id,
  };
  var _re = await db.collection("bmi").add(data).then((DocumentReference doc) {
    print('DocumentSnapshot added with ID: ${doc.id}');
    return doc.id;
  });
  return _re;
}

Future<void> getBmiData(String id) async {
  var db = FirebaseFirestore.instance;
  db.collection("bmi").where("id", isEqualTo: id).get().then(
    (querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {}
    },
    onError: (e) => print("Error completing: $e"),
  );
}

Future<void> RegisterUserData(String account, Map<String, dynamic> data) async {
  var db = FirebaseFirestore.instance;
  db
      .collection("user")
      .doc(account)
      .set(data)
      .onError((e, _) => print("Error writing document: $e"));
}

Future<Map<String, dynamic>?> GetUserData(String id) async {
  Map<String, dynamic> ReturnData;

  var documentSnapshot =
      await FirebaseFirestore.instance.collection("user").doc(id).get();
  if (documentSnapshot.exists) {
    var data = documentSnapshot.data();
    if (data != null) {
      ReturnData = data;
      return ReturnData;
    } else {
      return null;
    }
  }
}

Future<List?> get_data(String student_id, String position) async {
  List<String> a = [];
  try {
    var documentSnapshot = await FirebaseFirestore.instance
        .collection(position)
        .doc(student_id)
        .get();
    if (documentSnapshot.exists) {
      var data = documentSnapshot.data();
      if (data != null) {
        print(data.values.toString() + data.values.length.toString());
        for (var i = 0; i < data.values.length; i++) {
          a.add(data.values.elementAt(i));
        }
        return a;
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

void show_share_BottomSheet(BuildContext context, String id) {
  print("asdasdwadwad:" + id);
  showModalBottomSheet(
      backgroundColor: Colors.white,
      showDragHandle: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(50),
          child: QrImageView(
            data: id.toString(),
            version: QrVersions.auto,
            size: 320,
            gapless: false,
          ),
        );
      });
}
