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
  Future<UserCredential>signUpWithEmailPassword(String email, password) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } 
    on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }
  }

  //signout
  Future<void>signOut() async{
    return await _auth.signOut();
  }


  //errors
}