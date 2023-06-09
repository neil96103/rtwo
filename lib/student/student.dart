import 'package:flutter/material.dart';

import '../teacher/class.dart';

var user = ["學生Ａ", "male", "12345"];

class Student extends StatefulWidget {
  final List student_type;
  const Student({super.key, required this.student_type});

  @override
  State<Student> createState() => _StudentState();
}

//學生首頁
class _StudentState extends State<Student> {
  //生成修課清單
  courseList(int num) {
    return List.generate(num, (index) {
      return Column(
        children: [
          SizedBox(
            width: 340,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Class_page(class_type: [
                              "課堂${200 - (index + 1)}",
                              "$index",
                              "0"
                            ])));
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 255, 0, 0),
                backgroundColor: Color.fromARGB(255, 74, 74, 74),
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
                  size: 50,
                ),
                trailing: Text("修課人數：0"),
              ),
            ),
          ),
        ],
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
              //學生資訊顯示
              SizedBox(
                width: 400,
                child: Card(
                  color: const Color.fromARGB(0, 45, 45, 48),
                  elevation: 15.0,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14.0))),
                  child: ListTile(
                    title: Text(user[0].toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 30)),
                    subtitle: const Text('歡迎回來'),
                    leading: Icon(
                      Icons.person,
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
                      onPressed: () => {},
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(5),
              ),
              //修課清單
              ExpansionTile(
                initiallyExpanded: true,
                iconColor: const Color.fromARGB(255, 255, 255, 255),
                textColor: const Color.fromARGB(255, 255, 255, 255),
                title: const Text("課程"),
                leading: const Icon(Icons.bookmark_rounded),
                trailing: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  color: Colors.white,
                  icon: const Icon(
                    Icons.add_circle_rounded,
                  ),
                  onPressed: () {},
                ),
                children: [
                  SizedBox(
                    height: 618,
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1, //横轴三个子widget
                              childAspectRatio: 5 //宽高比为1时，子widget
                              ),
                      children: courseList(10),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
