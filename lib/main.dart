import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ulanish/HomePage.dart';
import 'package:ulanish/SignIn.dart';
import 'package:ulanish/services/Pref.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isLogin=false;
  login()async{
    String? id=await Pref.getUserId("");
    setState(() {
      if(id==null){
        isLogin=false;
      }else{
        isLogin=true;
      }
    });
    
  }
  @override
  void initState() {
   login();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isLogin!? HomePage():SignIn()
    );
  }
}
