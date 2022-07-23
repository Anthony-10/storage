/*import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _userEmail = TextEditingController();
  final TextEditingController _userPassWord = TextEditingController();

  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 30.0),
        child: SingleChildScrollView(
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
                key: const ValueKey("UserPassword"),
                textAlign: TextAlign.start,
                decoration: const InputDecoration(
                  labelText: "PassWord",
                ),
                controller: _userPassWord,
              ),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    loginController.createUser(
                        email: _userEmail.text, password: _userPassWord.text);
                  },
                  child: const Text('Sign up')),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
