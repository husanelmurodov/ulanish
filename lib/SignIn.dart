

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ulanish/HomePage.dart';
import 'package:ulanish/SignUp.dart';
import 'package:ulanish/services/Auth.dart';
import 'package:ulanish/services/Pref.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isloading = false;
  _signIn() {
    setState(() {
      isloading = true;
    });
    String? email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      return;
    }
    Auth.signIn(email, password).then((user) {
      saveUserId(user);
    });
  }

  saveUserId(FirebaseUser? user) async {
    setState(() {
      isloading = false;
    });
    if (user != null) {
      await Pref.saveUserId(user.uid);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => const HomePage())));
      print(user.uid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Email yoki parol xato"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Welcome SignIn",
                    style: TextStyle(color: Colors.orange, fontSize: 70),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: "email"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: "password"),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orange)),
                      child: Text("SignIn")),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 140),
                      child: Text("Don't have an account?"),
                    ),
                    SizedBox(
                      width: 9.5,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => SignUp())));
                      },
                      child: Text("Sign Up"),
                    )
                  ],
                )
              ],
            ),
          ),
          isloading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
