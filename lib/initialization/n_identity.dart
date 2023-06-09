import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:rtwo/student/student.dart';

import '../firebase/custom_firebase.dart';
import '../teacher/teacher.dart';

final TextEditingController tf_ID = TextEditingController();
final TextEditingController tf_Name = TextEditingController();
final TextEditingController tf_Password = TextEditingController();

var _tabTextIndexSelected = 0;
final _listTextTabToggle = ["我是學生", "我是老師"];

class identity extends StatefulWidget {
  const identity({super.key});

  @override
  State<identity> createState() => _identityState();
}

class _identityState extends State<identity> {
  var account_button = false;
  var LoginOrRegister = 0;
  var Password;
// 1 = 沒帳號 ,2 = 有帳號
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(children: [
                    const Padding(padding: EdgeInsets.only(top: 100)),
                    const Image(
                        image: AssetImage("assets/images/app_logo.png")),
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
                              style:
                                  TextStyle(fontSize: 14.0, color: Colors.grey),
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

                    TextField(
                      onEditingComplete: () {
                        firebase_login(
                                tf_ID.text,
                                (_tabTextIndexSelected == 0
                                    ? "student"
                                    : "teacher"))
                            .then((value) {
                          if (value == "no") {
                            LoginOrRegister = 1;
                            setState(() {});
                          } else {
                            LoginOrRegister = 2;
                            Password = value.toString();
                            setState(() {});
                          }
                          print("asd" +
                              LoginOrRegister.toString() +
                              " + " +
                              value);
                        });
                      },
                      controller: tf_ID,
                      decoration: InputDecoration(
                        hintText: _tabTextIndexSelected == 0 ? "學生編號" : "老師編號",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                        suffixIcon: !account_button
                            ? IconButton(
                                icon: const Icon(Icons.arrow_circle_right),
                                iconSize: 30,
                                onPressed: () {
                                  //Navigator.push(context, MaterialPageRoute(builder: (context) => Teacher()));
                                  setState(() {
                                    if (tf_ID.text.isEmpty) {
                                      account_button = false;
                                    } else {
                                      account_button = true;
                                      firebase_login(
                                              tf_ID.text,
                                              (_tabTextIndexSelected == 0
                                                  ? "student"
                                                  : "teacher"))
                                          .then((value) {
                                        if (value == "no") {
                                          LoginOrRegister = 1;
                                          setState(() {});
                                        } else {
                                          LoginOrRegister = 2;
                                          Password = value.toString();
                                          setState(() {});
                                        }
                                        print("asd" +
                                            LoginOrRegister.toString() +
                                            " + " +
                                            value);
                                      });
                                    }
                                  });
                                })
                            : null,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(5)),
                    LoginOrRegister == 1 && account_button
                        ? TextField(
                            controller: tf_Name,
                            decoration: InputDecoration(
                              hintText: "暱稱",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                          )
                        : const Padding(padding: EdgeInsets.zero),
                    LoginOrRegister == 1 && account_button
                        ? const Padding(padding: EdgeInsets.all(5))
                        : const Padding(padding: EdgeInsets.zero),

                    account_button
                        ? TextField(
                            controller: tf_Password,
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
                                    var userdata = {
                                      "password": tf_Password.text,
                                      "name": tf_Name.text,
                                    };
                                    LoginOrRegister == 1
                                        ? (FirebaseFirestore.instance
                                            .collection(
                                                _tabTextIndexSelected == 0
                                                    ? "student"
                                                    : "teacher")
                                            .doc(tf_ID.text)
                                            .set(userdata)
                                            .onError((e, _) => print(
                                                "Error writing document: $e"))
                                            .then((value) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        (_tabTextIndexSelected ==
                                                                0
                                                            ? Student(
                                                                student_type: [
                                                                  tf_ID.text
                                                                ],
                                                              )
                                                            : const Teacher())));
                                          }))
                                        : (tf_Password.text == Password
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        (_tabTextIndexSelected ==
                                                                0
                                                            ? Student(
                                                                student_type: [
                                                                  tf_ID.text
                                                                ],
                                                              )
                                                            : const Teacher())))
                                            : null);
                                  }),
                            ),
                          )
                        : Padding(padding: EdgeInsets.zero),

                    // _tabTextIndexSelected == 0 ? Student() : Teacher(),
                  ]),
                ),
              ),
            ],
          )),
    );
  }
}
