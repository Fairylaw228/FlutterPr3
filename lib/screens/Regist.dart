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
import 'package:flutter_auth/screens/SimleUser.dart';
import '../domain/entity/role_entity.dart';
import 'Auntification.dart';

class RegistationScreen extends StatefulWidget {
  const RegistationScreen({super.key});

  @override
  wgt.State<StatefulWidget> createState() => RegistationScreenState();
}

class RegistationScreenState extends wgt.State<RegistationScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

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
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 0),
                        child: TextFormField(
                          controller: checkLog,
                          validator: (value) {
                            if (value == null || value == "") {
                              return "не пустое";
                            }
                            if (value.length < 5) {
                              return "минимум 5";
                            }
                            if (value.length > 13) {
                              return "больше 12 нельзя";
                            }

                            return null;
                          },
                          decoration: const InputDecoration(hintText: "логин"),
                        ),
                      ),
                      TextFormField(
                        controller: checkPas,
                        validator: (value) {
                          if (value == null || value == "") {
                            return "не пустой";
                          }
                          if (value.length < 5) {
                            return "более 5";
                          }
                          if (value.length > 13) {
                            return "менее 13";
                          }
                          if (!value.contains(RegExp(r'[A-Z]'))) {
                            return "Большую букву нужно";
                          }
                          if (!value.contains(RegExp(r'[0-9]'))) {
                            return "цифру тоже нужно";
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
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;

                        String login = checkLog.text;
                        String password = checkPas.text;

                        Future<Either<String, bool>> result =
                            AuthRepositoryImplementation()
                                .checkLoginExists(login);
                        bool loginExitsts = false;
                        result.then((value) {
                          if (value.isRight()) {
                            final snackBar =
                                SnackBar(content: Text("Уже есть такой"));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            final snackBar = SnackBar(content: Text("ошибка"));

                            String hashPass =
                                md5.convert(utf8.encode(password)).toString();
                            Future<Either<String, bool>> result =
                                AuthRepositoryImplementation()
                                    .signUp(login, hashPass);

                            result.then((value) {
                              if (value.isRight()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Auntification()));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            });
                          }
                        });
                      },
                      child: const Text(
                        "регистрация",
                        style: TextStyle(fontSize: 25),
                        selectionColor: Color.fromARGB(255, 39, 111, 179),
                      )),
                ),
                ElevatedButton(
                    onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Auntification()))
                        },
                    child: const Text(
                      "вернуться",
                      style: TextStyle(fontSize: 25),
                      selectionColor: Color.fromARGB(111, 204, 111, 35),
                    )),
              ],
            ),
            Expanded(child: Container()),
          ],
        ));
  }
}
