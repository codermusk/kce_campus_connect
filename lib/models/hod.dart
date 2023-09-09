import 'dart:js_util';

class Hod {
  String name;

  String email;

  String phoneNumber;

  List<String> classes;


  Hod(
      {required this.name,
      required this.email,
      required this.phoneNumber,
      required this.classes});

  Map toJson(){
    Map map = {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'classes': classes
    };
    return map;
  }
 static fromJson(Map map){
    Hod hod = new Hod(name: map['name'], email: map['email'], phoneNumber: map['phoneNumber'], classes: map['classes']);
    return hod;
 }

}
