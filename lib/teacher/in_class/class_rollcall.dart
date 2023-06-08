import 'package:flutter/material.dart';

class ClassRollCall extends StatefulWidget {
  const ClassRollCall({super.key});

  @override
  State<ClassRollCall> createState() => _ClassRollCallState();
}

class _ClassRollCallState extends State<ClassRollCall> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
      children: <Widget>[
        ExpansionTile(
          iconColor: const Color.fromARGB(255, 255, 255, 255),
          textColor: const Color.fromARGB(255, 255, 255, 255),
          title: const Text("尚未簽到學生"),
          leading: const Icon(Icons.disabled_by_default_rounded),
          children: [
            Container(
              height: 300,
              child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, //横轴三个子widget
                      childAspectRatio: 2 //宽高比为1时，子widget
                      ),
                  children: const <Widget>[
                    Icon(Icons.ac_unit),
                    Icon(Icons.airport_shuttle),
                    Icon(Icons.all_inclusive),
                    Icon(Icons.beach_access),
                    Icon(Icons.cake),
                    Icon(Icons.free_breakfast),
                    Icon(Icons.ac_unit),
                    Icon(Icons.airport_shuttle),
                    Icon(Icons.all_inclusive),
                    Icon(Icons.beach_access),
                    Icon(Icons.cake),
                    Icon(Icons.free_breakfast),
                    Icon(Icons.ac_unit),
                    Icon(Icons.airport_shuttle),
                    Icon(Icons.all_inclusive),
                    Icon(Icons.beach_access),
                    Icon(Icons.cake),
                    Icon(Icons.free_breakfast),
                    Icon(Icons.ac_unit),
                    Icon(Icons.airport_shuttle),
                    Icon(Icons.all_inclusive),
                    Icon(Icons.beach_access),
                    Icon(Icons.cake),
                    Icon(Icons.free_breakfast),
                    Icon(Icons.ac_unit),
                    Icon(Icons.airport_shuttle),
                    Icon(Icons.all_inclusive),
                    Icon(Icons.beach_access),
                    Icon(Icons.cake),
                    Icon(Icons.free_breakfast),
                  ]),
            )
          ],
        ),
        ExpansionTile(
          iconColor: const Color.fromARGB(255, 255, 255, 255),
          textColor: const Color.fromARGB(255, 255, 255, 255),
          title: const Text("已簽到學生"),
          leading: const Icon(Icons.done_all_rounded),
          children: [
            Container(
              height: 300,
              child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, //横轴三个子widget
                      childAspectRatio: 2 //宽高比为1时，子widget
                      ),
                  children: const <Widget>[
                    Icon(Icons.ac_unit),
                    Icon(Icons.airport_shuttle),
                    Icon(Icons.all_inclusive),
                    Icon(Icons.beach_access),
                    Icon(Icons.cake),
                    Icon(Icons.free_breakfast),
                    Icon(Icons.ac_unit),
                    Icon(Icons.airport_shuttle),
                    Icon(Icons.all_inclusive),
                    Icon(Icons.beach_access),
                    Icon(Icons.cake),
                    Icon(Icons.free_breakfast),
                    Icon(Icons.ac_unit),
                    Icon(Icons.airport_shuttle),
                    Icon(Icons.all_inclusive),
                    Icon(Icons.beach_access),
                    Icon(Icons.cake),
                    Icon(Icons.free_breakfast),
                    Icon(Icons.ac_unit),
                    Icon(Icons.airport_shuttle),
                    Icon(Icons.all_inclusive),
                    Icon(Icons.beach_access),
                    Icon(Icons.cake),
                    Icon(Icons.free_breakfast),
                    Icon(Icons.ac_unit),
                    Icon(Icons.airport_shuttle),
                    Icon(Icons.all_inclusive),
                    Icon(Icons.beach_access),
                    Icon(Icons.cake),
                    Icon(Icons.free_breakfast),
                  ]),
            )
          ],
        ),
      ],
    );
  }
}
