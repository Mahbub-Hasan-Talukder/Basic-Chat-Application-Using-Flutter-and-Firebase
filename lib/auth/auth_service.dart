import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  //istance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;


  //signin
  Future<UserCredential>signInWithEmailPassword(String email, password) async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } 
    on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }
  }

  //signup


  //signout


  //errors
}