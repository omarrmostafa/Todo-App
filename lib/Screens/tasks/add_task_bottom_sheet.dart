import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/Screens/tasks/TaskModel.dart';
import 'package:todo_app/shared/firebase/firebase_function.dart';

class TaskBottomSheet extends StatefulWidget {
  const TaskBottomSheet({super.key});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {

  var titleController = TextEditingController();

  var descriptionController = TextEditingController();

  var selectedDate = DateTime.now();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Add Task",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "please enter task title";
                }
                return null;
              },
              controller: titleController,
              decoration: InputDecoration(
                  label: Text("Task Title"),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: MyThemeData.Primary))),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "please enter task Description";
                }
                return null;
              },
              controller: descriptionController,
              decoration: InputDecoration(
                  label: Text("Task Description"),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: MyThemeData.Primary))),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Text(
                "Selected date",
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 100),
              child: InkWell(
                  onTap: () {
                    selectDate(context);
                  },
                  child: Text(selectedDate.toString().substring(0, 10))),
            ),
            SizedBox(
              height: 35,
            ),
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    TaskModel taskModel = TaskModel(
                      userId: FirebaseAuth.instance.currentUser!.uid,
                        title: titleController.text,
                        Description: descriptionController.text,
                        date: DateUtils.dateOnly(selectedDate)
                            .millisecondsSinceEpoch);
                    FirebaseFunctions.addTask(taskModel);
                    Navigator.pop(context);
                  }
                  ;
                },
                child: Text("Add Task"))
          ],
        ),
      ),
    );
  }

  selectDate(BuildContext context) async {
    DateTime? chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate == null) {
      return;
    } else {
      selectedDate = chosenDate;
      setState(() {});
    }
  }
}
