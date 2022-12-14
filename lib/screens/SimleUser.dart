import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/screens/Auntification.dart';

class SimpleUser extends StatefulWidget {
  const SimpleUser({super.key});

  @override
  State<StatefulWidget> createState() {
    return SimpleUserState();
  }
}

class SimpleUserState extends State<SimpleUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 106, 20, 109),
      body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "низший слой",
              style: TextStyle(fontSize: 25),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Auntification()));
                },
                child: const Text(
                  "уйти отсюда",
                  style: TextStyle(fontSize: 25),
                ))
          ],
        ),
      ]),
    );
  }
}
