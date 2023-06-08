import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rtwo/teacher/in_class/class_rollcall.dart';

import 'in_class/class_Information.dart';

class Class_page extends StatefulWidget {
  const Class_page({super.key, required this.class_type});
  final List class_type;

  @override
  State<Class_page> createState() => _Class_pageState(class_type: class_type);
}

class _Class_pageState extends State<Class_page> {
  bool open_join = false;
  final List class_type;
  _Class_pageState({required this.class_type});
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 52, 54, 70),
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 14, 14, 15),
          elevation: 0,
        ),
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
                child: Column(children: [
              Text(
                class_type[0],
                style: const TextStyle(fontSize: 40),
              ),
              Text(
                "修課人數" + class_type[2],
                style: const TextStyle(fontSize: 20, color: Colors.white60),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      CupertinoSwitch(
                        value: open_join,
                        onChanged: (value) {
                          setState(() {
                            open_join ? open_join = false : open_join = true;
                          });
                        },
                      ),
                      const Text("開放加入課程"),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            class_type[1],
                            style: const TextStyle(fontSize: 30),
                          ),
                          const Text("課程代碼"),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.copy,
                          size: 20,
                        ),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: class_type[1]));
                          var snackbar = const SnackBar(
                              behavior: SnackBarBehavior.floating,
                              duration: Duration(milliseconds: 500),
                              content: Text("成功複製"));
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        },
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 505,
                child: _selectedIndex == 0
                    ? const ClassInformation()
                    : const ClassRollCall(),
              ),
            ]))),
        bottomNavigationBar: SafeArea(
            minimum: const EdgeInsets.only(bottom: 5, left: 20, right: 20),
            child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(60.0),
                  ),
                  child: BottomNavigationBar(
                    currentIndex: _selectedIndex,
                    onTap: _onItemTapped,
                    type: BottomNavigationBarType.shifting,
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.white60,
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: '課程資訊',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.wifi_tethering),
                        label: '點名',
                      ),
                    ],
                  ),
                ))));
  }
}
