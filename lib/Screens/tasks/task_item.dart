import 'package:flutter/material.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/shared/firebase/TaskModel.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/shared/firebase/firebase_function.dart';

class TasksItem extends StatelessWidget {
  TasksItem({super.key, required this.task});

  TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation:12 ,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Slidable(
          startActionPane: ActionPane(motion: DrawerMotion(), children: [
            SlidableAction(
              onPressed: (context) {
                FirebaseFunctions.deleteTask(task.id!);
              },
              icon: Icons.delete,
              label: "Delete",
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14)),
              backgroundColor: Colors.red,
            ),
            SlidableAction(
              onPressed: (context) {},
              icon: Icons.edit,
              label: "Edit",
              backgroundColor: Colors.blue,
            )
          ]),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(children: [
              Container(
                height: 80,
                width: 3,
                decoration: BoxDecoration(
                    color: MyThemeData.Primary,
                    borderRadius: BorderRadius.circular(18)),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title??""),
                  Text(task.Description??""),
                ],
              ),
              Spacer(),
              task.isDone!?
              Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.green,
                  ),
                  child: Text("Done",style: TextStyle(color: Colors.white),)
                  )
              :InkWell(
                onTap: () {
                  task.isDone = true;
                  FirebaseFunctions.updateTask(task);
                },
                child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blue,
                    ),
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                    )),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
