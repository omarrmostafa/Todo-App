class userModel {
  String id;
  String name;
  int age;
  String email;

  userModel(
      {required this.id, required this.name, required this.age, required this.email});

  userModel.fromJson(Map<String, dynamic>json) :this(
    id: json['id'],
    age: json['age'],
    email: json['email'],
    name: json['name'],
  );
  Map<String,dynamic>toJson(){
    return {
      "id": id,
      "age": age,
      "email": email,
      "name": name,
    };
  }
}