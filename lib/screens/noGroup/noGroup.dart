import 'package:book_club/screens/createGroup/createGroup.dart';
import 'package:book_club/screens/joinGroup/joinGroup.dart';
import 'package:book_club/screens/login/login.dart';
import 'package:flutter/material.dart';

import '../../modules/userModel.dart';

class NoGroup extends StatelessWidget {
  final UserModel? userModel;
  const NoGroup({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _goToJoin(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => JoinGroup(),
        ),
      );
    }

    void _goToCreate(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateGroup(
            userModel: userModel,
          ),
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Spacer(
            flex: 1,
          ),
          Padding(
            padding: EdgeInsets.all(80.0),
            child: Image.asset("assets/book-clubs-logo.png"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              "Welcome to Book Club",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40.0,
                color: Colors.grey[600],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Since your not in a book club, you can select ether " +
                  "to join a club or create a clube",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey[600],
              ),
            ),
          ),
          Spacer(
            flex: 1,
          ),
          // RaisedButton(
          //   onPressed: () async {
          //     await CurrentState().singOut();
          //     Navigator.of(context)
          //         .push(MaterialPageRoute(builder: (context) => LogIn()));
          //   },
          //   child: Text("ldnkj"),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  onPressed: () => _goToCreate(context),
                  child: Text("Create"),
                  color: Theme.of(context).canvasColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(
                        color: Theme.of(context).secondaryHeaderColor,
                        width: 2,
                      )),
                ),
                RaisedButton(
                  onPressed: () => _goToJoin(context),
                  child: Text(
                    "Join",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
