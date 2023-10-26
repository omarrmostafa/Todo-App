import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Layout/home_layout.dart';
import 'package:todo_app/Screens/Login/Login.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/provider/myProvider.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
      create: (context) => MyProvider(),
      child:  MyApp()));
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return MaterialApp(
      theme: MyThemeData.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: provider.firebaseUser!=null?HomeLayout.routeName:Login.routeName,
      routes: {
        HomeLayout.routeName:(context) => HomeLayout(),
        Login.routeName:(context) => Login(),


      });
  }
}
