import 'dart:async';

import 'package:book_club/modules/authModel.dart';
import 'package:book_club/modules/book.dart';
import 'package:book_club/modules/groupModel.dart';
import 'package:book_club/service/dbFutures.dart';
import 'package:book_club/utils/timeLeft.dart';
import 'package:book_club/widget/ourContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopCard extends StatefulWidget {
  const TopCard({Key? key}) : super(key: key);

  @override
  State<TopCard> createState() => _TopCardState();
}

class _TopCardState extends State<TopCard> {
  String? _timeUntil;
  AuthModel? _authModel;
  Timer? _timer;
  BookModel? _currentBook;
  GroupModel? _groupModel;
  bool _doneWithBook = true;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _timeUntil = TimeLeft.timeLeft(_groupModel!.currentBookDue!.toDate());
      });
    });
  }

  @override
  void didChangeDependencies() async {
    _authModel = Provider.of<AuthModel>(context);
    _groupModel = Provider.of<GroupModel>(context);

    if (_groupModel != null) {
      // isUserDoneWithBook();

      _currentBook = await DBFuture()
          .getCurrentBookinfo(_groupModel?.id, _groupModel?.currentBookId);
      _startTimer();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ShadowContainer(
            child: Column(
          children: [
            Text(
              _currentBook?.name ?? 'loading',
              style: TextStyle(
                fontSize: 25,
                color: Colors.grey[600],
              ),
            ),
            Text(
              _currentBook?.author ?? 'loading',
              style: TextStyle(
                fontSize: 25,
                color: Colors.grey[600],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                children: [
                  Text(
                    "Due In: ",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.grey[600],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      // '',
                      _timeUntil == null ? 'Loading' : _timeUntil.toString(),
                      // timeIntil!.isEmpty
                      //     ? "loading"
                      //     : timeIntil![0] ?? 'loading...',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: () {},
              // value.getDoneWithCurrentBook ? null : _gotoReview,
              child: Text(
                'Finshed Book',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
