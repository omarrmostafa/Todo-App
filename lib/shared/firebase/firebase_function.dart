import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/shared/firebase/TaskModel.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromjson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.tojson();
      },
    );
  }

  static Future<void> addTask(TaskModel taskModel) {
    var collection = getTasksCollection();
    var docRef = collection.doc();
    taskModel.id = docRef.id;
    return docRef.set(taskModel);
  }

  static void deleteTask(String id) {
    getTasksCollection().doc(id).delete();
  }

  static void updateTask(TaskModel task) {
    getTasksCollection().doc(task.id).update((task.tojson()));
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime dateTime) {
    return getTasksCollection()
        .where("date", isEqualTo: dateTime.millisecondsSinceEpoch)
        .snapshots();
  }
}
