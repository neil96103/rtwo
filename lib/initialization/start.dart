import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'n_identity.dart';

final List<String> imageList = [
  "assets/images/ikea_shortcut.png",
  "assets/images/shark_shortcut.png",
  "assets/images/furniture_shortcut.png",
];
final List<String> textList = [
  "IKEA絕版品出清! ",
  "限量鯊魚抱枕 現在只要490",
  "限量歐式風格沙發 現在只要2880",
];

class StartPage extends StatefulWidget {
  const StartPage({super.key, required this.title});

  final String title;

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int imageIndex = 0; //當前的第n張照片
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
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 100.0),
                Image(image: AssetImage("assets/images/app_logo.png")),
                SizedBox(height: 15.0),
                const Column(
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
                const SizedBox(
                  height: 50,
                ),
                //ikea廣告跑馬燈
                SizedBox(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: CarouselSlider.builder(
                          itemCount: imageList.length,
                          options: CarouselOptions(
                              enlargeCenterPage: true,
                              height: 200,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 5),
                              reverse: false,
                              aspectRatio: 5.0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  imageIndex = index;
                                });
                              }),
                          itemBuilder: (context, i, id) {
                            return Container(
                                width: 600,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image(
                                    image: AssetImage(imageList[i]),
                                    fit: BoxFit.cover,
                                  ),
                                ));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(textList[imageIndex],
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white70)),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(0, 240, 255, 0.65),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => identity()));
                          },
                          child: const Text("開始使用",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5))),
                    )),
                /*
            Container(
              height: 100,
              margin: const EdgeInsets.only(top: 40),
              child:const LoadingIndicator(
                  indicatorType: Indicator.ballClipRotatePulse,
                  colors: [Colors.white],
                  strokeWidth: 0.5,
              ),
            ),
            const Text("載入中 : 20%",style: TextStyle(fontSize:18,color: Colors.white),),
            */
              ]),
        ));
  }
}
