import 'package:book_club/modules/authModel.dart';
import 'package:book_club/modules/groupModel.dart';
import 'package:book_club/modules/userModel.dart';
import 'package:book_club/screens/noGroup/noGroup.dart';
import 'package:book_club/service/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service/dbStreams.dart';
import '../ingroup/home.dart';
import '../login/login.dart';
import '../splashScreen/splashScreen.dart';

enum AuthState { notLoggedIn, unkown, loggedin, inGroup }

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  AuthState _authState = AuthState.unkown;
  String? _currenUid;

  // @override
  // void initState() async{
  //   // TODO: implement initState
  //   super.initState();
  //   await _authState
  // }

  @override
  void didChangeDependencies() async {
    final _authStream = Provider.of<AuthModel>(context);

    if (_authStream.email != "") {
      setState(() {
        _authState = AuthState.loggedin;
        _currenUid = _authStream.uid;
      });
    } else {
      setState(() {
        _authState = AuthState.notLoggedIn;
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Widget? retval;
    switch (_authState) {
      case AuthState.unkown:
        retval = SplashScreen();

        break;
      case AuthState.notLoggedIn:
        retval = LogIn();
        break;
      case AuthState.loggedin:
        retval = StreamProvider<UserModel>.value(
          value: DBStream().getcurrentUser(_currenUid!),
          initialData: UserModel(
              uid: null, email: null, timeCreated: null, groupId: null),
          child: LoggedIn(),
        );
        break;

      default:
    }
    return retval!;
  }
}

class LoggedIn extends StatelessWidget {
  const LoggedIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel _userStream = Provider.of<UserModel>(context);
    Widget? retVal;

    if (_userStream.groupId != null) {
      retVal = StreamProvider<GroupModel>.value(
          value: DBStream().getcurrentGroup(_userStream.groupId!),
          initialData: GroupModel(
              id: null,
              name: null,
              currentBookId: null,
              currentBookDue: null,
              groupCreated: null,
              members: null,
              leader: null),
          child: InGroup());
    } else {
      retVal = NoGroup(
        userModel: _userStream,
      );
    }
    return retVal;
  }
}
