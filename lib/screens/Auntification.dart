//import 'package:dartz/dartz.dart';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as wgt;
import 'package:flutter_auth/data/repositories/auth_repository_implementation.dart';
import 'package:flutter_auth/domain/usecases/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/screens/Admin.dart';
import 'package:flutter_auth/screens/Regist.dart';
import 'package:flutter_auth/screens/SimleUser.dart';
import '../domain/entity/role_entity.dart';

class Auntification extends StatefulWidget {
  const Auntification({super.key});

  @override
  wgt.State<StatefulWidget> createState() => AuntificationState();
}

class AuntificationState extends wgt.State<Auntification> {
  GlobalKey<FormState> globalKey = GlobalKey();

  TextEditingController checkLog = TextEditingController();

  TextEditingController checkPas = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 106, 20, 109),
        body: Column(
          children: [
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
              child: Form(
                  key: globalKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 0),
                        child: TextFormField(
                          controller: checkLog,
                          validator: (value) {
                            if (value == null || value == "") {
                              return "Это поле не может быть пустым";
                            }
                            if (value.length < 5) {
                              return "Минимум 5 символов";
                            }
                            if (value.length > 25) {
                              return "Максимум 25 символов";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: "логин там",
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: checkPas,
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Это поле не может быть пустым";
                          }
                          if (value.length < 5) {
                            return "Минимум 5 символов";
                          }
                          if (value.length > 25) {
                            return "Максимум 25 символов";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(hintText: "пароль"),
                      )
                    ],
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                      onPressed: () {
                        if (!globalKey.currentState!.validate()) return;

                        String login = checkLog.text;
                        String password = checkPas.text;

                        final snackBar = SnackBar(
                          content: Text("Вы не тот."),
                        );
                        String hashPass =
                            md5.convert(utf8.encode(password)).toString();
                        Future<Either<String, RoleEnum>> result =
                            AuthRepositoryImplementation()
                                .signIn(login, hashPass);

                        result.then((value) {
                          if (value.isRight()) {
                            RoleEnum enumResult =
                                value.getOrElse(() => RoleEnum.anonymous);
                            switch (enumResult) {
                              case RoleEnum.admin:
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Admin()));
                                break;
                              case RoleEnum.user:
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SimpleUser()));
                                break;
                              default:
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                            }
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        });
                      },
                      child: const Text(
                        "Войти",
                        style: TextStyle(fontSize: 25),
                        selectionColor: Color.fromARGB(255, 83, 201, 99),
                      )),
                ),
                ElevatedButton(
                    onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistationScreen()))
                        },
                    child: const Text("регистрация",
                        style: TextStyle(fontSize: 25),
                        selectionColor: Color.fromARGB(255, 83, 201, 99))),
              ],
            ),
            Expanded(child: Container()),
          ],
        ));
  }
}
