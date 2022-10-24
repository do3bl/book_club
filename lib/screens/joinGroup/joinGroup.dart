import 'package:book_club/modules/userModel.dart';
import 'package:book_club/service/dbFutures.dart';
import 'package:book_club/widget/ourContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../roots/root.dart';

class JoinGroup extends StatefulWidget {
  const JoinGroup({Key? key}) : super(key: key);

  @override
  State<JoinGroup> createState() => _JoinGroupState();
}

class _JoinGroupState extends State<JoinGroup> {
  TextEditingController _groupidController = TextEditingController();
  void joinGroup(BuildContext context, String groupid) async {
    UserModel _currentUser = Provider.of<UserModel>(context, listen: false);
    String _returnString =
        await DBFuture().joinGroup(groupid, _currentUser.uid!);
    if (_returnString == 'success') {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Root(),
          ),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: [BackButton()],
              ),
            ),
            // Spacer(
            //   flex: 3,
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: ShadowContainer(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _groupidController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.group),
                        hintText: "Group Id",
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 100),
                        child: Text(
                          "Join",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ),
                      onPressed: () =>
                          joinGroup(context, _groupidController.text),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
