class TaskModel {
   String? id;
   String? title;
   String? Description;
   int? date;
   bool? isDone;
   String userId;
  TaskModel({this.id = "",
    required this.title,
     required this.userId,
    required this.Description,
    required this.date,
    this.isDone = false});


  // عندي اختياران يا الفانكشن ديه يا الي تحتيها الاتنين ينفعوا
  //الاتنين دول الي بعملهم عشان احول من map ل model والعكس عشان اسهل علي نفسي بعد كده

  TaskModel.fromjson(Map<String, dynamic> json)
      : this(
      title: json['title'],
      Description: json['description'],
      date: json['date'],
      userId: json['userId'],
      isDone: json['isDone'],
      id: json['id']);

// TaskModel fromjson(Map<String, dynamic> json) {
//   return TaskModel(
//       title: json['title'],
//       Description: json['description'],
//       date: json['date'],
//       isDone: json['isDone'],
//       id: json['id']);
// }

  Map<String, dynamic> tojson() {
    return{
      "title": title,
      "userId": userId,
      "Description": Description,
      "date": date,
      "isDone": isDone,
      "id":id,
  };
  }
}