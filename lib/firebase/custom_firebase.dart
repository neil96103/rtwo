import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> firebase_login(String documentId, String position) async {
  try {
    var documentSnapshot = await FirebaseFirestore.instance
        .collection(position)
        .doc(documentId)
        .get();
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
