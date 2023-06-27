import 'package:flutter/material.dart';
import 'package:rtwo/page1/nav.dart';

import '../firebase/custom_firebase.dart';

final TextEditingController tf_ID = TextEditingController();
final TextEditingController tf_Name = TextEditingController();
final TextEditingController tf_Password = TextEditingController();
var LoginOrRegister = 0;
var account_button = false;
var Password;

class BMI_identity extends StatefulWidget {
  const BMI_identity({super.key});

  @override
  State<BMI_identity> createState() => _BMI_identityState();
}

class _BMI_identityState extends State<BMI_identity> {
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
                    TextField(
                      onEditingComplete: () {
                        if (!tf_ID.text.isEmpty) {
                          firebase_login(tf_ID.text).then((value) {
                            if (value == "no") {
                              LoginOrRegister = 1;
                              //註冊模式
                              setState(() {});
                            } else {
                              LoginOrRegister = 2;
                              //登入模式
                              Password = value.toString();
                              setState(() {});
                            }
                            account_button = true;
                            print("GetPassword : " + value);
                          });
                        } else {
                          LoginOrRegister = 0;
                          Password = "";
                          account_button = false;
                          setState(() {});
                        }
                      },
                      controller: tf_ID,
                      decoration: InputDecoration(
                        hintText: "帳號",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(5)),

                    //暱稱（註冊模式）
                    LoginOrRegister == 1
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
                        //暱稱（登入模式）
                        : const Padding(padding: EdgeInsets.zero),

                    //空格（登入＆註冊模式）
                    LoginOrRegister == 1
                        ? const Padding(padding: EdgeInsets.all(5))
                        : const Padding(padding: EdgeInsets.zero),

                    //密碼（確認是否顯示）
                    account_button == true
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
                                    Map<String, dynamic> userdata = {
                                      "password": tf_Password.text,
                                      "name": tf_Name.text,
                                      "user_id": tf_ID.text,
                                      "sex": "male"
                                      //TODO:性別還沒改
                                    };
                                    // 密碼（註冊模式）
                                    LoginOrRegister == 1
                                        ? (
                                            RegisterUserData(
                                                    tf_ID.text, userdata)
                                                .then((value) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          (nav(
                                                              UserData:
                                                                  userdata))));
                                            }),
                                          )
                                        // 有帳號
                                        : (tf_Password.text == Password
                                            ? GetUserData(tf_ID.text).then(
                                                (value) => (value != null
                                                    ? Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                (nav(
                                                                    UserData:
                                                                        value))))
                                                    : null))
                                            : null);
                                  }),
                            ),
                          )
                        : const Padding(padding: EdgeInsets.zero),

                    // _tabTextIndexSelected == 0 ? Student() : Teacher(),
                  ]),
                ),
              ),
            ],
          )),
    );
  }
}
