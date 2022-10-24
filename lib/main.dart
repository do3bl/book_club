import 'package:book_club/modules/authModel.dart';
import 'package:book_club/modules/userModel.dart';
import 'package:book_club/screens/roots/root.dart';
import 'package:book_club/service/auth.dart';
import 'package:book_club/service/dbStreams.dart';
import 'package:book_club/utils/ourThems.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<AuthModel?>.value(
          value: Auth().onAuthStateChanged,
          initialData: AuthModel(email: "", uid: ""),
        ),
      ],
      child: MainMaterial(),
    );
  }
}

class MainMaterial extends StatelessWidget {
  const MainMaterial({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: OurThems().buildTheme(),
      home: const Root(),
    );
  }
}
