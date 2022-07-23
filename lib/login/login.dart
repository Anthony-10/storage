import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storage/login/regester.dart';

import 'login_controller.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _userEmail = TextEditingController();

  final TextEditingController _userPassWord = TextEditingController();

  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 100, right: 40, left: 40),
          child: Column(
            children: [
              TextFormField(
                key: const ValueKey("UserEmail"),
                textAlign: TextAlign.start,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
                controller: _userEmail,
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                obscureText: true,
                key: const ValueKey("UserPassWord"),
                textAlign: TextAlign.start,
                decoration: const InputDecoration(
                  labelText: "PassWord",
                ),
                controller: _userPassWord,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              ElevatedButton(
                  onPressed: () {
                    loginController.logIn(
                        email: _userEmail.text, password: _userPassWord.text);
                  },
                  child: const Text('Sign In')),
              /*TextButton(
                  onPressed: () => Get.to(() => Register()),
                  child: const Text("register if not"))*/
            ],
          ),
        ),
      ),
    );
  }
}
