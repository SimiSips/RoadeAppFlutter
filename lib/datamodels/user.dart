/*

import 'package:firebase_database/firebase_database.dart';

class Users{
  String fullName;
  String email;
  String phone;
  String id;

  Users({
    required this.email,
    required this.fullName,
    required this.phone,
    required this.id,
  });

  Users.fromSnapshot(DataSnapshot snapshot){
    id = snapshot.key!;
    phone = snapshot.value['phone'];
    email = snapshot.value['email'];
    fullName = snapshot.value['fullname'];
  }

}
*/
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class User{
  late String fullName;
  late String email;
  late String phone;
  late String id;

  User({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.id,

  });

  User.fromSnapshot(DataSnapshot snapshot){
    id = snapshot.key!;
    phone = snapshot.value['phone'];
    email = snapshot.value['email'];
    fullName = snapshot.value['fullname'];
  }
}



