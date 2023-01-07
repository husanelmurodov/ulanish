import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ulanish/SignIn.dart';
import 'package:ulanish/services/Auth.dart';
import 'package:ulanish/services/Pref.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasController = TextEditingController();
   bool isLoading = false;
  _signUp() {
   
    String? name = fullnameController.text.trim();
    String? email = emailController.text.trim();
    String password = passwordController.text.trim();
    String? repas = repasController.text.trim();
    if (name.isEmpty || email.isEmpty || password.isEmpty || repas.isEmpty) {
      return;
    }
    if (password != repas) {
      return;
    }

    setState(() {
      isLoading = true;
    });
    Auth.signUp(email, password).then((value) {
      _saveId(value);
      setState(() {
        isLoading = false;
      });
    });
  }

  _saveId(FirebaseUser? user) async {
    if (user != null) {
      await Pref.saveUserId(user.uid);
      Navigator.push(
          context, MaterialPageRoute(builder: ((context) => SignIn())));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Bironbir xato bo'ldi")));
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
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Welcome SignUp",
                    style: TextStyle(color: Colors.orange, fontSize: 70),
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(labelText: "fullname"),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const TextField(
                  decoration: InputDecoration(labelText: "email"),
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextField(
                  decoration: InputDecoration(labelText: "password"),
                ),
                const TextField(
                  decoration: InputDecoration(labelText: "qaytaparol"),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        _signUp();
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orange)),
                      child: Text("SignUp")),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 150),
                      child: Text("Don't have an account?"),
                    ),
                    const SizedBox(
                      width: 9.5,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => SignIn())));
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          isLoading? Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ):Container(),
        ]
      ),
    );
  }
}
