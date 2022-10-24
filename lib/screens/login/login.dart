import 'package:book_club/screens/login/loacal_widgets.dart/loginForm.dart';
import 'package:flutter/material.dart';

class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: [
                Padding(
                  padding: EdgeInsets.all(40),
                  child: Image.asset("assets/book-clubs-logo.png"),
                ),
                const SizedBox(
                  height: 20,
                ),
                LoginForm(),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
