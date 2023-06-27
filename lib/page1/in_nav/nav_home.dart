import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rtwo/firebase/custom_firebase.dart';

final TextEditingController height = TextEditingController();
final TextEditingController weight = TextEditingController();
var bmi = "";
var is_save = "";

class nav_home extends StatefulWidget {
  const nav_home({super.key, required this.UserData});
  final Map<String, dynamic> UserData;
  @override
  State<nav_home> createState() => _nav_homeState(UserData: UserData);
}

class _nav_homeState extends State<nav_home> {
  final Map<String, dynamic> UserData;
  _nav_homeState({required this.UserData});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(50),
                    child: Column(
                      children: [
                        const Text(
                          "BMI 計算器",
                          style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        Text(
                          bmi == "" ? '為你的健康把關' : bmiDetermine(bmi),
                          style: TextStyle(
                              fontSize: bmi == "" ? 14.0 : 25,
                              color: bmi == "" ? Colors.grey : bmiColor(bmi)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextField(
                          controller: height,
                          decoration: InputDecoration(
                            hintText: "身高（公分）",
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextField(
                          controller: weight,
                          decoration: InputDecoration(
                            hintText: "體重（公斤）",
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            (bmi != "" && is_save != "")
                                ? ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            116, 255, 255, 255),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0))),
                                    onPressed: () {
                                      show_share_BottomSheet(is_save);
                                    },
                                    child: const Text("分享",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1.5)))
                                : const Padding(padding: EdgeInsets.zero),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(0, 240, 255, 0.65),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0))),
                                onPressed: () {
                                  is_save = "";
                                  weight.text == ""
                                      ? null
                                      : (height.text == ""
                                          ? null
                                          : bmi = bmiCalculator(
                                              height.text, weight.text));
                                  print(bmi);
                                  setState(() {});
                                },
                                child: Text(bmi == "" ? "計算" : "再次計算",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.5))),
                            bmi != ""
                                ? ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Color.fromARGB(163, 35, 145, 255),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0))),
                                    onPressed: () {
                                      is_save = "";
                                      addBmiData(bmi, height.text, weight.text,
                                              UserData["user_id"])
                                          .then((value) {
                                        is_save = value;
                                        setState(() {});
                                      });
                                    },
                                    child: const Text("儲存",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1.5)))
                                : const Padding(padding: EdgeInsets.zero),
                          ],
                        )
                      ],
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  void show_share_BottomSheet(String id) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        showDragHandle: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.all(50),
            child: QrImageView(
              data: id.toString(),
              version: QrVersions.auto,
              size: 320,
              gapless: false,
            ),
          );
        });
  }
}

String bmiCalculator(String height, String weight) {
  double h = double.parse(height) / 100.0;
  double w = double.parse(weight);
  double bmi = w / (h * h);
  return bmi.toStringAsFixed(2);
}

String bmiDetermine(String bmi) {
  double b = double.parse(bmi);
  String result;
  if (b < 18.5) {
    result = "你是氣球是不是（過輕）";
  } else if (b >= 18.5 && b < 24.0) {
    result = "阿你不就好棒棒（正常）";
  } else if (b >= 24.0 && b < 27.0) {
    result = "你該去跑步了（過重）";
  } else if (b >= 27.0 && b < 30.0) {
    result = "你好胖喔（輕度肥胖）";
  } else if (b >= 30.0 && b < 35.0) {
    result = "死肥豬快減肥啦（中度肥胖）";
  } else {
    result = "你沒救了（重度肥胖）";
  }
  return result;
}

Color bmiColor(String bmi) {
  double b = double.parse(bmi);
  Color result;
  if (b < 18.5) {
    result = const Color.fromARGB(255, 0, 215, 222);
  } else if (b >= 18.5 && b < 24.0) {
    result = Color.fromARGB(255, 0, 222, 56);
  } else if (b >= 24.0 && b < 27.0) {
    result = Color.fromARGB(255, 196, 222, 0);
  } else if (b >= 27.0 && b < 30.0) {
    result = Color.fromARGB(255, 222, 178, 0);
  } else if (b >= 30.0 && b < 35.0) {
    result = Color.fromARGB(255, 222, 96, 0);
  } else {
    result = Color.fromARGB(255, 222, 0, 0);
  }
  return result;
}
