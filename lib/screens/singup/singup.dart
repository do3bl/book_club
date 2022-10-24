import 'package:book_club/screens/login/loacal_widgets.dart/loginForm.dart';
import 'package:book_club/screens/singup/local_widget/singUpForm.dart';
import 'package:flutter/material.dart';

class SingUp extends StatelessWidget {
  const SingUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BackButton(),
                  ],
                ),
                SizedBox(
                  height: 40.0,
                ),
                SingUpForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
