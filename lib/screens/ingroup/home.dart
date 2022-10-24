import 'dart:async';

import 'package:book_club/modules/book.dart';
import 'package:book_club/modules/groupModel.dart';
import 'package:book_club/modules/userModel.dart';
import 'package:book_club/screens/addBook/addBook.dart';
import 'package:book_club/screens/ingroup/secondCard.dart';
import 'package:book_club/screens/ingroup/topCard.dart';
import 'package:book_club/screens/roots/root.dart';
import 'package:book_club/service/auth.dart';
import 'package:book_club/utils/timeLeft.dart';
import 'package:book_club/widget/ourContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InGroup extends StatefulWidget {
  const InGroup({Key? key}) : super(key: key);

  @override
  State<InGroup> createState() => _InGroupState();
}

class _InGroupState extends State<InGroup> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  // void _gotoReview() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => OurReivew()),
  //   );
  // }

  void _singOut(BuildContext context) async {
    // CurrentState _currentUser =
    //     Provider.of<CurrentState>(context, listen: false);
    String returnString = await Auth().singOut();
    if (returnString == "success") {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Root()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 40,
          ),
          TopCard(),
          Padding(padding: const EdgeInsets.all(20.0), child: SeconedCard()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
            child: RaisedButton(
              child: Text(
                'Book Club History',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
              // onPressed: () => _goToaddBook(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: RaisedButton(
              child: Text(
                'SingOut',
              ),
              onPressed: () => _singOut(context),
              color: Theme.of(context).canvasColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(
                    color: Theme.of(context).secondaryHeaderColor,
                    width: 2,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
