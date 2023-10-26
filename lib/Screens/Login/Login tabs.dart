import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Layout/home_layout.dart';
import 'package:todo_app/provider/myProvider.dart';
import 'package:todo_app/shared/firebase/firebase_function.dart';

class LoginTabs extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var prov=Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                final bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                if (!emailValid) {
                  return "please enter valid email";
                }
                return null;
              },
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                final bool passwardValid = RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                    .hasMatch(value);
                if (!passwardValid) {
                  return "please enter valid passward";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  FirebaseFunctions.login(
                      emailController.text, passwordController.text, () {
                        prov.initUser();
                    Navigator.pushNamedAndRemoveUntil(
                        context, HomeLayout.routeName, (route) => false,);
                  }, (errorMassage) {
                    showDialog(
                      barrierDismissible: false ,
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Error"),
                        content: Text(errorMassage),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("ok"))
                        ],
                      ),
                    );
                  });
                }
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
