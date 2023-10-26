import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/shared/firebase/firebase_function.dart';
import 'package:todo_app/userModel.dart';

class MyProvider extends ChangeNotifier{
  userModel? usermodel;
  User? firebaseUser;
  MyProvider(){
    firebaseUser=FirebaseAuth.instance.currentUser!;
    initUser();
  }
  initUser()async{
    firebaseUser=FirebaseAuth.instance.currentUser;
    usermodel=await FirebaseFunctions.readUserFromFirestore(firebaseUser!.uid);
    notifyListeners();
  }
}