import 'package:auto_size_text/auto_size_text.dart';

import 'package:book_club/screens/roots/root.dart';
import 'package:book_club/service/auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widget/ourContainer.dart';
import '../../singup/singup.dart';

enum LoginType {
  email,
  google,
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  _loginUser(LoginType type, String? email, String? password) async {
    try {
      String? _returnString;
      switch (type) {
        case LoginType.email:
          _returnString = await Auth().logInUserWithEmail(email!, password!);
          break;
        case LoginType.google:
          _returnString = await Auth().logInUserWithGoogle();
          break;
        default:
      }
      if (_returnString == "seccess") {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Root()));
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Incorrect Login Info "),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  Widget _googleButton() {
    return OutlineButton(
      onPressed: () {
        _loginUser(LoginType.google, null, null);
      },
      splashColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          // padding: EdgeInsets.only(left: 1),
          child: Row(
            children: [
              Image(
                image: AssetImage("assets/google-logo.png"),
                height: 25.0,
              ),
              // Padding(
              // padding: const EdgeInsets.only(left: 10),
              Text(
                "Sing In with Google",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              // ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
            child: Text(
              "Log In",
              style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.alternate_email),
              hintText: "Email",
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_outline),
              hintText: "Password",
            ),
            obscureText: true,
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                _loginUser(LoginType.email, _emailController.text,
                    _passwordController.text);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: AutoSizeText(
                  "Log In",
                  maxFontSize: 18.0,
                  style: TextStyle(
                      color: Colors.white,
                      // fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (contxet) => SingUp()));
            },
            child: Text("Dont have an account? Sing up here"),
          ),
          _googleButton()
        ],
      ),
    );
  }
}
