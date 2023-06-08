import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> readStudentData() async {
  var db = FirebaseFirestore.instance;
  await db.collection("student").get().then((event) {
    for (var doc in event.docs) {
      print("${doc.id} => ${doc.data()}");
    }
  });
}