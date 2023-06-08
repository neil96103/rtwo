import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../student/student.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

import '../teacher/teacher.dart';

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
                selectedBackgroundColors: const [Color.fromRGBO(0, 178, 239, 0.85)],
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
                  : _identityTeacher(),
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
class _identityStudentState extends State<identityStudent>{

  final TextEditingController tf_TeacherID = TextEditingController();
  final TextEditingController tf_TeacherName = TextEditingController();
  final TextEditingController tf_TeacherPassword = TextEditingController();
  var _check = false;  //判斷登入按鈕是否被點擊

  Widget showLoginUI(var documentId){
    CollectionReference users = FirebaseFirestore.instance.collection('student');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        //其他問題(沒開網路)
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        //註冊
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }
        //登入
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          var password = data['password'];
          return Padding(
              padding: const EdgeInsets.fromLTRB(20,10,20,0),
              child: TextField(
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
                  suffixIcon: Container(
                    margin: const EdgeInsets.all(8),
                    child: IconButton(
                        icon: const Icon(Icons.arrow_circle_right),
                        iconSize: 30,
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Teacher()));
                        }),
                  ),
                ),
              ));
        }
        return Text("loading");
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
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
                suffixIcon: Container(
                  margin: EdgeInsets.all(8),
                  child: IconButton(
                      icon: const Icon(Icons.arrow_circle_right),
                      iconSize: 30,
                      onPressed: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => Teacher()));
                        setState(() {
                          if(tf_TeacherID.text.isEmpty){
                            _check = false;
                          }else{
                            _check = true;
                          }
                        });
                      }),
                ),
              ),
            )),
        //觸發顯示登入/註冊介面
        _check?showLoginUI(tf_TeacherID.text):Padding(padding: EdgeInsets.zero),
      ],
    );
  }
}

class _identityTeacher extends StatelessWidget {
  final TextEditingController tf_StudentID = TextEditingController();
  final TextEditingController tf_StudentName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Teacher()));
                      }),
                ),
              ),
            ))
      ],
    );
  }
}

