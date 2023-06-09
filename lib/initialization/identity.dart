import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

final TextEditingController tf_TeacherID = TextEditingController();
final TextEditingController tf_TeacherName = TextEditingController();
final TextEditingController tf_TeacherPassword = TextEditingController();

var _check = false; //判斷登入按鈕是否被點擊

class identity extends StatefulWidget {
  const identity({super.key});

  @override
  State<identity> createState() => _identityState();
}

class _identityState extends State<identity> {
  var _tabTextIndexSelected = 0;
  final _listTextTabToggle = ["我是學生", "我是老師"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 14, 14, 15),
              Color.fromARGB(255, 52, 54, 70)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(top: 100)),
              const Image(image: AssetImage("assets/images/app_logo.png")),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "RTWO",
                        style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      Text(
                        'Rapid with Rollcall',
                        style: TextStyle(fontSize: 14.0, color: Colors.grey),
                      ),
                    ]),
              ),
              FlutterToggleTab(
                width: 90,
                borderRadius: 15,
                height: 50,
                selectedIndex: _tabTextIndexSelected,
                selectedBackgroundColors: const [
                  Color.fromRGBO(0, 178, 239, 0.85)
                ],
                selectedTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
                unSelectedTextStyle: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                labels: _listTextTabToggle,
                selectedLabelIndex: (index) {
                  setState(() {
                    _tabTextIndexSelected = index;
                  });
                },
                isScroll: false,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              _tabTextIndexSelected == 0
                  ? identityStudent()
                  : identityTeacher(),
            ],
          )),
    );
  }
}

class identityStudent extends StatefulWidget {
  const identityStudent({super.key});

  @override
  State<identityStudent> createState() => _identityStudentState();
}

class _identityStudentState extends State<identityStudent> {
  var _check = false; //判斷登入按鈕是否被點擊
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            controller: tf_TeacherID,
            decoration: InputDecoration(
              hintText: "學生編號",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
              suffixIcon: !_check
                  ? IconButton(
                      icon: const Icon(Icons.arrow_circle_right),
                      iconSize: 30,
                      onPressed: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => Teacher()));
                        setState(() {
                          if (tf_TeacherID.text.isEmpty) {
                            _check = false;
                          } else {
                            _check = true;
                          }
                        });
                      })
                  : null,
            ),
          ),
          const Padding(padding: EdgeInsets.all(5)),
          //觸發顯示登入/註冊介面
          _check
              ? showLoginUI(tf_TeacherID, "student")
              : const Padding(padding: EdgeInsets.zero),
        ],
      ),
    ));
  }
}

class identityTeacher extends StatefulWidget {
  const identityTeacher({super.key});

  @override
  State<identityTeacher> createState() => _identityTeacherState();
}

class _identityTeacherState extends State<identityTeacher> {
  final TextEditingController tf_StudentID = TextEditingController();
  final TextEditingController tf_StudentName = TextEditingController();

  var _check = false; //判斷登入按鈕是否被點擊

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              decoration: InputDecoration(
                hintText: "老師編號",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
                suffixIcon: Container(
                  margin: const EdgeInsets.all(8),
                  child: IconButton(
                      icon: const Icon(Icons.arrow_circle_right),
                      iconSize: 30,
                      onPressed: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => Teacher()));
                        setState(() {
                          if (tf_StudentID.text.isEmpty) {
                            _check = false;
                          } else {
                            _check = true;
                          }
                        });
                      }),
                ),
              ),
            )),
        //觸發顯示登入/註冊介面
        _check
            ? showLoginUI(tf_StudentID.text, "student")
            : Padding(padding: EdgeInsets.zero),
      ],
    );
  }
}

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
        return "no data";
      }
    } else {
      return "no account";
    }
  } catch (e) {
    return "other error";
  }
}

Widget showLoginUI(var documentId, String position) {
  final TextEditingController password = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('student');
  return FutureBuilder<DocumentSnapshot>(
    future: users.doc(documentId.text).get(),
    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      //其他問題(沒開網路)
      if (snapshot.hasError) {
        return const Text("出現其他問題，請稍後再試");
      }
      //註冊
      if (snapshot.hasData && !snapshot.data!.exists) {
        return TextField(
          controller: password,
          decoration: InputDecoration(
            hintText: "密碼",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1,
                style: BorderStyle.solid,
              ),
            ),
            suffixIcon: IconButton(
                icon: const Icon(Icons.arrow_circle_right),
                iconSize: 30,
                onPressed: () {
                  print("sad");
                  var userdata = {
                    "password": password.text,
                  };

                  FirebaseFirestore.instance
                      .collection(position)
                      .doc(documentId.text)
                      .set(userdata)
                      .onError((e, _) => print("Error writing document: $e"));
                }),
          ),
        );
      }
      //登入
      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;

        return TextField(
          controller: password,
          decoration: InputDecoration(
            hintText: "密碼",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1,
                style: BorderStyle.solid,
              ),
            ),
            suffixIcon: IconButton(
                icon: const Icon(Icons.arrow_circle_right),
                iconSize: 30,
                onPressed: () {
                  print(data['password']);
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => Teacher()));
                }),
          ),
        );
      }
      return const Text("檢查中");
    },
  );
}
