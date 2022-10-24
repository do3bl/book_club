import 'package:book_club/modules/book.dart';
import 'package:book_club/modules/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class DBFuture {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createGroup(
      String groupName, UserModel user, BookModel initialBook) async {
    String retval = 'error';
    List<String> members = [];

    try {
      members.add(user.uid!);
      DocumentReference _docref = await _firestore.collection('groups').add({
        'name': groupName,
        'leader': user.uid,
        'members': members,
        'groupCreate': Timestamp.now(),
        'nextBookId': "waiting",
        'indexPickingBook': 0
      });
      await _firestore
          .collection('users')
          .doc(user.uid)
          .update({'groupId': _docref.id});

      // add a book
      addBook(_docref.id, initialBook);
      retval = 'success';
    } catch (e) {
      print(e);
    }
    return retval;
  }

  Future<String> joinGroup(String groupId, String userId) async {
    String retval = 'error';
    List<String> members = [];
    try {
      members.add(userId);
      await _firestore.collection("groups").doc(groupId).update({
        'members': FieldValue.arrayUnion(members),
      });
      await _firestore
          .collection('users')
          .doc(userId)
          .update({'groupId': groupId});
      retval = 'success';
    } on PlatformException catch (e) {
      retval = "Make sure you have the right group ID!";
      print(e);
    } catch (e) {
      print(e);
    }
    return retval;
  }

  Future<String> addBook(String groupId, BookModel book) async {
    String retval = 'error';

    try {
      DocumentReference _docref = await _firestore
          .collection("groups")
          .doc(groupId)
          .collection('books')
          .add({
        'name': book.name,
        'author': book.author,
        'length': book.length,
        'completaedOn': book.dateComplated
      });
      // add current book to group schedule
      await _firestore.collection("groups").doc(groupId).update(
          {'currentBookId': _docref.id, 'currentBookDue': book.dateComplated});

      retval = 'success';
    } catch (e) {
      print(e);
    }
    return retval;
  }

  Future<String> addNextBook(String groupId, BookModel book) async {
    String retval = 'error';

    try {
      DocumentReference _docref = await _firestore
          .collection("groups")
          .doc(groupId)
          .collection('books')
          .add({
        'name': book.name,
        'author': book.author,
        'length': book.length,
        'completaedOn': book.dateComplated
      });
      // add current book to group schedule
      await _firestore.collection("groups").doc(groupId).update({
        'nextBookId': _docref.id,
      });

      retval = 'success';
    } catch (e) {
      print(e);
    }
    return retval;
  }

  Future<String> addCurrentBook(String groupId, BookModel book) async {
    String retVal = "error";

    try {
      DocumentReference _docRef = await _firestore
          .collection("groups")
          .doc(groupId)
          .collection("books")
          .add({
        'name': book.name,
        'author': book.author,
        'length': book.length,
        'dateCompleted': book.dateComplated,
      });

      //add current book to group schedule
      await _firestore.collection("groups").doc(groupId).update({
        "currentBookId": _docRef.id,
        "currentBookDue": book.dateComplated,
      });

      //adding a notification document
      // DocumentSnapshot doc =
      //     await _firestore.collection("groups").document(groupId).get();
      // createNotifications(
      //     List<String>.from(doc.data["tokens"]) ?? [], book.name, book.author);

      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<BookModel> getCurrentBookinfo(String? groupId, String? bookId) async {
    BookModel retVal = BookModel();

    try {
      DocumentSnapshot _docSnapshot = await _firestore
          .collection("groups")
          .doc(groupId)
          .collection('books')
          .doc(bookId)
          .get();
      retVal.id = bookId;
      retVal.name = _docSnapshot["name"];
      retVal.length = _docSnapshot["length"];
      retVal.dateComplated = _docSnapshot["completaedOn"];
      retVal.author = _docSnapshot["author"];
    } catch (e) {
      print(e);
    }
    // print(retVal);
    return retVal;
  }

  Future<BookModel> getNextBookinfo(String? groupId, String? bookId) async {
    BookModel retVal = BookModel();

    try {
      DocumentSnapshot _docSnapshot = await _firestore
          .collection("groups")
          .doc(groupId)
          .collection('books')
          .doc(bookId)
          .get();
      retVal.id = bookId;
      retVal.name = _docSnapshot["name"];
      retVal.length = _docSnapshot["length"];
      retVal.dateComplated = _docSnapshot["completaedOn"];
      retVal.author = _docSnapshot["author"];
    } catch (e) {
      print(e);
    }
    // print(retVal);
    return retVal;
  }

  Future<bool> isUserDoneWithBook(
      String? groupId, String? bookId, String? uid) async {
    bool retVal = false;
    try {
      DocumentSnapshot _docSnapshot = await _firestore
          .collection("groups")
          .doc(groupId)
          .collection('books')
          .doc(bookId)
          .collection('reviews')
          .doc(uid)
          .get();
      if (_docSnapshot.exists) {
        retVal = true;
      }
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<UserModel> getUser(String? uid) async {
    UserModel retVal = UserModel();

    try {
      DocumentSnapshot _docSnapshot =
          await _firestore.collection("users").doc(uid).get();
      retVal = UserModel.fromDoucmontSnapshot(
          id: _docSnapshot.id, doc: _docSnapshot);
    } catch (e) {
      print(e);
    }
    // print(retVal);
    return retVal;
  }
}
