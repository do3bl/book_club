import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  String? id;
  String? name;
  String? leader;
  List? members;
  // List<String>? tokens;
  Timestamp? groupCreated;
  String? currentBookId;
  int? indexPickingBook;
  String? nextBookId;
  Timestamp? currentBookDue;
  Timestamp? nextBookDue;

  // Timestamp? currentBookDue;

  GroupModel({
    this.id,
    this.name,
    this.leader,
    this.members,
    // this.tokens,
    this.groupCreated,
    this.currentBookId,
    this.indexPickingBook,
    this.nextBookId,
    this.currentBookDue,
    this.nextBookDue,
  });

  factory GroupModel.fromDoucmentSnapshot(doc, String groupid) {
    return GroupModel(
      id: groupid,
      name: doc["name"],
      leader: doc["leader"],
      members: doc["members"],
      // tokens: List<String>.from(doc.data["tokens"] ?? []),
      groupCreated: doc["groupCreate"],
      currentBookId: doc["currentBookId"],
      indexPickingBook: doc["indexPickingBook"],
      nextBookId: doc["nextBookId"],
      currentBookDue: doc["currentBookDue"],
      nextBookDue: doc["nextBookDue"],
    );
  }
}
