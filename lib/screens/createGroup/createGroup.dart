import 'package:book_club/modules/userModel.dart';
import 'package:book_club/screens/addBook/addBook.dart';
import 'package:book_club/screens/roots/root.dart';
import 'package:book_club/widget/ourContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateGroup extends StatefulWidget {
  UserModel? userModel;
  CreateGroup({Key? key, required this.userModel}) : super(key: key);

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  void gotoAddBook(BuildContext context, String groupName) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddBook(
          curentUser: widget.userModel,
          groupNmae: groupName,
          ourGroupCreation: true,
        ),
      ),
    );
  }

  TextEditingController _groupNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: [BackButton()],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: ShadowContainer(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _groupNameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.group),
                        hintText: "Add Book",
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 100),
                        child: Text(
                          "Add Book",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ),
                      onPressed: () =>
                          gotoAddBook(context, _groupNameController.text),
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
