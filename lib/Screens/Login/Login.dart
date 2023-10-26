import 'package:flutter/material.dart';
import 'package:todo_app/Screens/Login/Login%20tabs.dart';
import 'package:todo_app/Screens/Login/signuotab.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  static const String routeName = "Login";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Login"),
            bottom: TabBar(tabs: [
              Tab(
                child: Text("Login"),
              ),
              Tab(child: Text("sign up"))
            ]),
          ),
          body: TabBarView(children: [LoginTabs(), signupTab()]),
        ));
  }
}
