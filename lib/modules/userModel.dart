import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? uid;
  String? email;
  Timestamp? timeCreated;
  String? fullName;
  String? groupId;

  UserModel({
    this.uid,
    this.email,
    this.timeCreated,
    this.groupId,
    this.fullName,
  });

  factory UserModel.fromDoucmontSnapshot({doc, String? id}) {
    return UserModel(
      uid: id,
      email: doc['email'],
      groupId: doc['groupId'],
      timeCreated: doc['accountCreated'],
      fullName: doc['fullName'],
    );
  }
}

//  uid:
//     id;
//     email:
//     doc!['email'];
//     timeCreated:
//     doc['accountCreated'];
//     groupId:
//     doc['groupid'];