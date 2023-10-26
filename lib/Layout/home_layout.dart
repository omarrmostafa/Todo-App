import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Screens/Login/Login.dart';
import 'package:todo_app/Screens/settings/settings_tab.dart';
import 'package:todo_app/Screens/tasks/tasks_tap.dart';
import 'package:todo_app/provider/myProvider.dart';

import '../Screens/tasks/add_task_bottom_sheet.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = "HomeLayout";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

  int index = 0;
  List<Widget>tabs=[TasksTab(),SettingsTab()];

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.pushNamedAndRemoveUntil(context, Login.routeName, (route) => false);
          }, icon:Icon(Icons.logout))
        ],
        title: Text("TO DO${provider.usermodel?.name}"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showsheet();
          },
          child: Icon(
            Icons.add,
          ),
          shape: CircleBorder(side: BorderSide(color: Colors.white, width: 3))),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 6,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onTap: (value) {
            index = value;
            setState(() {});
          },
          currentIndex: index,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  size: 32,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  size: 29,
                ),
                label: ""),
          ],
        ),
      ),
      body:tabs[index],
    );
  }
  showsheet(){
    showModalBottomSheet(context: context,isScrollControlled: true, builder: (context) {
      return Padding(
        padding:  EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),
        child: TaskBottomSheet(),
      );
    },
    );
  }
}
