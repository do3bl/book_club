import 'package:book_club/modules/groupModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../modules/userModel.dart';

class DBStream {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<UserModel> getcurrentUser(String id) {
    return _firestore.collection('users').doc(id).snapshots().map((snapShot) =>
        UserModel.fromDoucmontSnapshot(doc: snapShot.data(), id: id));
  }

  Stream<GroupModel> getcurrentGroup(String groupId) {
    final tttt = _firestore.collection('groups').doc(groupId).snapshots().map(
        (snapShot) =>
            GroupModel.fromDoucmentSnapshot(snapShot.data(), groupId));

    return _firestore.collection('groups').doc(groupId).snapshots().map(
        (snapShot) =>
            GroupModel.fromDoucmentSnapshot(snapShot.data(), groupId));
  }
}
