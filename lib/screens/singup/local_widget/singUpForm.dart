import 'package:book_club/screens/singup/singup.dart';
import 'package:book_club/service/auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widget/ourContainer.dart';

class SingUpForm extends StatefulWidget {
  const SingUpForm({Key? key}) : super(key: key);

  @override
  State<SingUpForm> createState() => _SingUpFormState();
}

class _SingUpFormState extends State<SingUpForm> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  void _singUpUser(String email, String password, BuildContext context,
      String fullname) async {
    try {
      String _returnString = await Auth().singUpUser(email, password, fullname);
      if (_returnString == "seccess") {
        Navigator.pop(context);
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(_returnString.toString()),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
            child: Text(
              "Sing Up",
              style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person_outline),
              hintText: "Full Name",
            ),
            controller: _fullNameController,
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.alternate_email),
              hintText: "Email",
            ),
            controller: _emailController,
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_outline),
              hintText: "Password",
            ),
            controller: _passwordController,
            obscureText: true,
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_outline),
              hintText: "Confirm Password",
            ),
            controller: _confirmPassword,
            obscureText: true,
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            onPressed: () {
              if (_passwordController.text == _confirmPassword.text) {
                _singUpUser(_emailController.text, _passwordController.text,
                    context, _fullNameController.text);
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                "Sing Up",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
