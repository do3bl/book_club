import 'package:book_club/modules/authModel.dart';
import 'package:book_club/modules/book.dart';
import 'package:book_club/modules/userModel.dart';
import 'package:book_club/screens/roots/root.dart';
import 'package:book_club/service/dbFutures.dart';
import 'package:book_club/widget/ourContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddBook extends StatefulWidget {
  final bool ourGroupCreation;
  final String groupNmae;
  final UserModel? curentUser;
  const AddBook({
    Key? key,
    required this.groupNmae,
    required this.ourGroupCreation,
    this.curentUser,
  }) : super(key: key);

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  TextEditingController _bookNameCntoller = TextEditingController();
  TextEditingController _authorCntoller = TextEditingController();
  TextEditingController _lengthCntoller = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked =
        await DatePicker.showDateTimePicker(context, showTitleActions: true);
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _addBook(BuildContext context, BookModel book, String groupName) async {
    print("ok");

    AuthModel _auth = Provider.of<AuthModel>(context, listen: false);
    // OurGroup grouid =
    //     await OurDataBae().getGroupinfo(_currentUser.getCurrentUser.groupId!);
    // print(grouid.name);
    String _returnString = 'error';
    if (widget.ourGroupCreation) {
      _returnString =
          await DBFuture().createGroup(groupName, widget.curentUser!, book);
    } else {
      _returnString =
          await DBFuture().addBook(widget.curentUser!.groupId!, book);
    }
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
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: [BackButton()],
              ),
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height / 3,
            // ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: ShadowContainer(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _bookNameCntoller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.group),
                        hintText: "Book Name",
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: _authorCntoller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.group),
                        hintText: "Author Name",
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: _lengthCntoller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.group),
                        hintText: "Length",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    // date picker
                    Text(DateFormat.yMMMd("en_US").format(_selectedDate)),
                    Text(DateFormat("H:mm").format(_selectedDate)),
                    FlatButton(
                      onPressed: () => _selectDate(context),
                      child: Text("change Date"),
                    ),
                    RaisedButton(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 100),
                        child: Text(
                          "Create",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ),
                      onPressed: () {
                        BookModel book = BookModel();

                        book.name = _bookNameCntoller.text;
                        book.author = _authorCntoller.text;
                        book.length = int.parse(_lengthCntoller.text);
                        book.dateComplated = Timestamp.fromDate(_selectedDate);
                        _addBook(context, book, widget.groupNmae);
                      },
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
