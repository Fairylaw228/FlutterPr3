import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Auntification.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<StatefulWidget> createState() {
    return AdminState();
  }
}

class AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 106, 20, 109),
      body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Вроде админ", style: TextStyle(fontSize: 25)),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Auntification()));
                },
                child: const Text(
                  "Уйти отсюда",
                  style: TextStyle(fontSize: 25),
                  selectionColor: Color.fromARGB(255, 83, 201, 99),
                ))
          ],
        ),
      ]),
    );
  }
}
