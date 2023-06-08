import 'package:flutter/material.dart';

import 'class.dart';

var user = ["老師Ａ", "male", "12345"];

// 老師設定頁面
class teacher_setting extends StatefulWidget {
  const teacher_setting({super.key});

  @override
  State<teacher_setting> createState() => _teacher_settingState();
}

class _teacher_settingState extends State<teacher_setting> {
  final TextEditingController tf_TeacherID = TextEditingController();
  final TextEditingController tf_TeacherName = TextEditingController();
  var Gender = user[1];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 600,
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.school),
                        hintText: "暱稱",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        )),
                    controller: tf_TeacherName,
                    keyboardType: TextInputType.text,
                    onChanged: (String value) {
                      print("${value}");
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.picture_in_picture_sharp),
                        hintText: "教師編號",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        )),
                    controller: tf_TeacherID,
                    keyboardType: TextInputType.text,
                    onChanged: (String value) {
                      print("${value}");
                    },
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(10),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              SizedBox(
                width: 150,
                child: FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: Color.fromARGB(66, 94, 94, 94),
                        elevation: 1,
                        surfaceTintColor: Colors.amberAccent),
                    onPressed: () {
                      Gender == "male" ? Gender = "female" : Gender = "male";
                      setState(() {});
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.school,
                          color: Gender == "male" ? Colors.blue : Colors.red,
                          size: 30,
                        ),
                        Text(
                          " 點擊修改性別",
                          style: TextStyle(
                              color:
                                  Gender == "male" ? Colors.blue : Colors.red),
                        )
                      ],
                    )),
              ),
              SizedBox(
                width: 150,
                child: FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: Color.fromARGB(66, 94, 94, 94),
                        elevation: 1,
                        surfaceTintColor: Colors.amberAccent),
                    onLongPress: () {
                      setState(() {
                        Gender = "";
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
                    },
                    onPressed: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.close_rounded,
                          color: Colors.red,
                        ),
                        Text(
                          " 長按登出",
                          style: TextStyle(color: Colors.red),
                        )
                      ],
                    )),
              ),
            ]),
            const Padding(
              padding: EdgeInsets.all(10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 150,
                  child: FilledButton(
                      style: FilledButton.styleFrom(
                          backgroundColor: Color.fromARGB(66, 94, 94, 94),
                          elevation: 1,
                          surfaceTintColor: Colors.amberAccent),
                      onPressed: () {
                        setState(() {
                          Gender = "";
                          Navigator.pop(context);
                        });
                      },
                      child: Icon(Icons.close_rounded)),
                ),
                SizedBox(
                  width: 150,
                  child: FilledButton(
                      style: FilledButton.styleFrom(
                          // backgroundColor: Color.fromARGB(66, 94, 94, 94),
                          elevation: 1,
                          surfaceTintColor: Colors.amberAccent),
                      onPressed: () {
                        setState(() {
                          user[1] = Gender;
                          if (tf_TeacherName.text != "") {
                            user[0] = tf_TeacherName.text;
                            tf_TeacherName.text = "";
                          }
                          if (tf_TeacherID.text != "") {
                            user[3] = tf_TeacherID.text;
                            tf_TeacherID.text = "";
                          }
                          Gender = "";

                          Navigator.pop(context);
                        });
                      },
                      child: Icon(Icons.check)),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(0),
            ),
          ],
        ));
  }
}

//老師首頁
class Teacher extends StatefulWidget {
  const Teacher({super.key});

  @override
  State<Teacher> createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void show_setting_BottomSheet() {
    showModalBottomSheet(
        showDragHandle: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        context: context,
        builder: (BuildContext context) {
          return teacher_setting();
        }).then((value) => setState(() {}));
  }

  void show_Class_BottomSheet() {
    final TextEditingController tfClassid = TextEditingController();
    showModalBottomSheet(
        isScrollControlled: true,
        showDragHandle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 500,
            child: Column(children: [
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.school),
                      hintText: "課程ID",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                      )),
                  controller: tfClassid,
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_comment_rounded, color: Colors.white),
                      Text("新增課程",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white))
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20),
                ),
                TextButton(
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.mode_comment, color: Colors.white),
                      Text("加入課程",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white))
                    ],
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ])
            ]),
          );
        });
  }

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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(40),
              ),
              SizedBox(
                width: 400,
                child: Card(
                  color: Color.fromARGB(0, 45, 45, 48),
                  elevation: 15.0, //设置阴影
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(14.0))), //设置圆角
                  child: ListTile(
                    title: Text(user[0].toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 30)),
                    subtitle: const Text('歡迎回來'),
                    leading: Icon(
                      Icons.school,
                      color: (user[1].toString() == "male")
                          ? Colors.blue
                          : Colors.red,
                      size: 60,
                    ),
                    trailing: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      color: Colors.white,
                      icon: const Icon(
                        Icons.settings,
                        size: 30,
                      ),
                      onPressed: show_setting_BottomSheet,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(5),
              ),
              SizedBox(
                width: 400,
                height: 50,
                child: Card(
                  color: const Color.fromARGB(0, 45, 45, 48),
                  elevation: 15.0, //设置阴影
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(14.0))), //设置圆角
                  child: ListTile(
                    title: const Text("課程",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20)),
                    leading: const Icon(
                      Icons.bookmark_rounded,
                      size: 30,
                    ),
                    trailing: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      color: Colors.white,
                      icon: const Icon(
                        Icons.add_circle_rounded,
                      ),
                      onPressed: () {
                        show_Class_BottomSheet();
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 350,
                child: Divider(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 570,
                child: Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(20, (index) {
                        return Column(
                          children: [
                            SizedBox(
                              width: 340,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Class_page(
                                                  class_type: [
                                                    "課堂${200 - (index + 1)}",
                                                    "$index",
                                                    "$_counter"
                                                  ])));
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor:
                                      const Color.fromARGB(255, 255, 0, 0),
                                  backgroundColor:
                                      Color.fromARGB(255, 74, 74, 74),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: ListTile(
                                  title: Text("課堂${200 - (index + 1)}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                      )),
                                  subtitle: const Text("學期:111-1"),
                                  leading: const Icon(
                                    Icons.accessibility_new_sharp,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                  trailing: Text("修課人數：$_counter"),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(5),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 350,
                child: Divider(
                  color: Colors.white,
                  height: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
