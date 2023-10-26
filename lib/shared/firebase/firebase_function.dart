import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/Screens/tasks/TaskModel.dart';
import 'package:todo_app/userModel.dart';

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
    return getTasksCollection().where("userId",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("date", isEqualTo: dateTime.millisecondsSinceEpoch)
        .snapshots();
  }

  static CollectionReference<userModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection("user")
        .withConverter<userModel>(
      fromFirestore: (snapshot, _) {
        return userModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  static Future<void> createUser(String name,int age,String email,String password,Function onsuccess,Function onerror)async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(credential.user?.uid!=null){
        userModel user=userModel(id: credential.user!.uid, name: name, age: age, email: email);
        addUserToFireSore(user).then((value) => (value) => onsuccess());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onerror("wrong mail or passward");
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        onerror("wrong mail or passward");
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void>login(String email,String password,Function onsuccess,Function onerror)async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      if(credential.user?.uid!=null){
       // var user=await readUserFromFirestore(credential.user!.uid);
        onsuccess();
      }

    } on FirebaseAuthException catch (e) {
        onerror("wrong mail or passward");
    }

  }

  static Future<void> addUserToFireSore(userModel userModel){
    var collection=getUserCollection();
    var docRef=collection.doc(userModel.id);
    return docRef.set(userModel);

  }

 static Future<userModel?>readUserFromFirestore(String id)async{
     DocumentSnapshot<userModel> doc=await
    getUserCollection().doc(id).get();
    return doc.data();

  }
}
