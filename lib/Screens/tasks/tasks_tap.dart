
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Screens/tasks/task_item.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/shared/firebase/firebase_function.dart';

class TasksTab extends StatefulWidget {


  static const String routeName = "TasksTab";

   TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime selectedTime=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          initialDate: selectedTime,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) {
            selectedTime = date;
            setState(() {});
          },
          leftMargin: 21,
          monthColor: MyThemeData.Primary,
          dayColor: MyThemeData.Primary,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: MyThemeData.Primary,
          dotsColor: Color(0xFF333A47),
          selectableDayPredicate: (date) => true,
          locale: 'en',
        ),
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFunctions.getTasks(selectedTime),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("error"));
              } else {
                var tasks =
                    snapshot.data?.docs.map((e) => e.data()).toList()??[];
                if(tasks.isEmpty){
                  return Center(child: Text("No tasks"));
                }
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return TasksItem(task: tasks[index],);
                  },
                  itemCount: tasks.length,
                );
              }
            },
          ),
        )
      ],
    );
  }
}
