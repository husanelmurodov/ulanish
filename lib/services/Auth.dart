
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ulanish/services/Pref.dart';
class Auth{
 static final _auth=FirebaseAuth.instance;
  static  Future<FirebaseUser?>signIn(String email, String password)async{
    try{
    _auth.signInWithEmailAndPassword(email: email, password: password);
      final FirebaseUser _user=await _auth.currentUser();
      
      return _user;
    }catch(error){
      print(error);
    }
    return null;
  }
  static Future <FirebaseUser?>signUp(String email,String password)async{
    try{  
   FirebaseUser _userCredential =await _auth.createUserWithEmailAndPassword(email: email, password: password);
return _userCredential;
    }catch(error){
      print(error);
    }
    return null;
  }
  static Future logount()async{
    await _auth.signOut();
    await Pref.removeId();
  }
}

class UserCredintal {
}




