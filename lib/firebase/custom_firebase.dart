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

Future<Object> get_student_data(String student_id) async {
  try {
    var documentSnapshot = await FirebaseFirestore.instance
        .collection("student")
        .doc(student_id)
        .get();
    if (documentSnapshot.exists) {
      var data = documentSnapshot.data();
      if (data != null && data.containsKey("password")) {
        return data;
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
