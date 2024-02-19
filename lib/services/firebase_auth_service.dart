import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hw_firebase_authentification/pages/home_page.dart';

class AuthService{
  static final _auth = FirebaseAuth.instance;
  static int count = 0;
  static  bool isRegistered = true;

  static Future<User?> registerUser(BuildContext context, {required String name, required String email, required String phoneNumber, required String password}) async {
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if(userCredential.user != null){
        await userCredential.user!.updateDisplayName(name);
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registered")));
        return userCredential.user;
      }
    }catch(e){
      Future.delayed(Duration.zero).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      });
      return null;
    }
  }

  static Future<User?> loginUser(BuildContext context, {required String email, required String password})async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if(userCredential.user != null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Successfully logged in")));
        return userCredential.user;
      }else{
        return null;
      }
    }catch(e){
      count++;
      Future.delayed(Duration.zero).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      });
      return null;
    }
  }

  static Future<void> logOut()async{
    await _auth.signOut();
  }

  static Future<void> deleteAccount()async{
    await _auth.currentUser?.delete();
  }

}