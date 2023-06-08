import 'package:flutter/material.dart';
import 'initialization/start.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  //firebase初始化
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Title',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const StartPage(
        title: 'hi',
      ),
    );
  }
}
