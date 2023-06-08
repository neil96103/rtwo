import 'package:flutter/material.dart';

class ClassInformation extends StatefulWidget {
  const ClassInformation({super.key});

  @override
  State<ClassInformation> createState() => _ClassInformationState();
}

class _ClassInformationState extends State<ClassInformation> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          SizedBox(
            width: 350,
            child: ExpansionTile(
              initiallyExpanded: true,
              iconColor: const Color.fromARGB(255, 255, 255, 255),
              textColor: const Color.fromARGB(255, 255, 255, 255),
              title: const Text("修課學生"),
              leading: const Icon(Icons.person_rounded),
              children: [
                SizedBox(
                  height: 445,
                  child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
          ),
        ]);
  }
}
