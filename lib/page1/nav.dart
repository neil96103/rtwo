import 'package:flutter/material.dart';
import 'package:rtwo/teacher/in_class/class_rollcall.dart';

import 'in_nav/nav_home.dart';

class nav extends StatefulWidget {
  const nav({super.key, required this.UserData});
  final Map<String, dynamic> UserData;

  @override
  State<nav> createState() => _navState(UserData: UserData);
}

class _navState extends State<nav> {
  final Map<String, dynamic> UserData;
  _navState({required this.UserData});
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
          backgroundColor: Color.fromARGB(0, 14, 14, 15),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: _selectedIndex == 0
              ? nav_home(
                  UserData: UserData,
                )
              : ClassRollCall(),
        ),
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
                        label: '首頁',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.wifi_tethering),
                        label: '其他',
                      ),
                    ],
                  ),
                ))));
  }
}
