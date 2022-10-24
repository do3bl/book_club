import 'package:book_club/modules/book.dart';
import 'package:book_club/modules/groupModel.dart';
import 'package:book_club/modules/userModel.dart';
import 'package:book_club/screens/addBook/addBook.dart';
import 'package:book_club/service/dbFutures.dart';
import 'package:book_club/widget/ourContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeconedCard extends StatefulWidget {
  @override
  State<SeconedCard> createState() => _SeconedCardState();
}

class _SeconedCardState extends State<SeconedCard> {
  //  SeconedCard({Key? key}) : super(key: key);
  GroupModel? _groupModel;

  UserModel? _currentUser;

  UserModel? _pickingUser;

  BookModel? _nextBook;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _groupModel = Provider.of<GroupModel>(context);
    _currentUser = Provider.of<UserModel>(context);
    _pickingUser = Provider.of<UserModel>(context);
    if (_groupModel!.id != null) {
      _pickingUser = await DBFuture()
          .getUser(_groupModel!.members?[_groupModel!.indexPickingBook!]);

      // setState(() {});
      _nextBook = await DBFuture()
          .getCurrentBookinfo(_groupModel!.id!, _groupModel!.nextBookId!);
      setState(() {});
      // print(_nextBook.name);
      // print(_nextBook.author);
    } else {
      print("not ok");
    }
  }

  void _goToaddBook(BuildContext context) {
    int? _nextIndx;
    int? _numOfMembers = _groupModel!.members!.length;

    if (_groupModel?.indexPickingBook == (_numOfMembers - 1)) {
      _nextIndx = 0;
    } else {
      _nextIndx = _groupModel!.indexPickingBook! + 1;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddBook(
                curentUser: _currentUser,
                groupNmae: _groupModel!.name!,
                ourGroupCreation: false,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: _displayText(),
      ),
    );
  }

  Widget _displayText() {
    Widget? retVal;
    if (_pickingUser != null) {
      if (_groupModel?.nextBookId == 'waiting') {
        if (_pickingUser?.uid == _currentUser?.uid) {
          retVal =
              TextButton(onPressed: () {}, child: Text('Select next Book'));
        } else {
          retVal = Text(
            'waiting for ' + _pickingUser!.fullName! + 'to pick',
            style: TextStyle(fontSize: 30, color: Colors.grey.withOpacity(0.5)),
          );
        }
      } else {
        retVal = retVal = Column(
          children: [
            Text(
              'Next Book Is:',
              style:
                  TextStyle(fontSize: 30, color: Colors.grey.withOpacity(0.5)),
            ),
            Text(
              _nextBook?.name ?? 'loading',
              style: TextStyle(
                fontSize: 25,
                color: Colors.grey[600],
              ),
            ),
            Text(
              _nextBook != null ? _nextBook!.author.toString() : 'hbhjb',
              style: TextStyle(
                fontSize: 25,
                color: Colors.grey[600],
              ),
            ),
          ],
        );
      }
    } else {
      retVal = Text(
        'Loading...',
        style: TextStyle(fontSize: 30, color: Colors.grey.withOpacity(0.5)),
      );
    }
    return retVal;
  }
}
