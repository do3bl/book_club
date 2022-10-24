import 'package:book_club/modules/authModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseAuth get getAuth => _auth;

  // Stream<AuthModel> get currentUser => _auth.authStateChanges().map(AuthModel.fromFirebaseUser());

  // Stream<AuthModel?> get currentUser =>
  //     _auth.authStateChanges().map((User? firebaseUser) {
  //       return firebaseUser != null
  //           ? AuthModel.fromFirebaseUser(user: firebaseUser)
  //           : AuthModel(uid: null, email: null);
  //     });

  Stream<AuthModel> get onAuthStateChanged =>
      _auth.authStateChanges().map((User? user) {
        if (user != null) {
          return AuthModel(email: user.email, uid: user.uid);
        } else {}
        return AuthModel(email: "", uid: "");
      });

  Future<String> singOut() async {
    String retval = "error";
    try {
      await _auth.signOut();
      // _currentUser = OurUsers();
      // _email = null;
      retval = "success";
    } catch (e) {
      print(e);
    }
    return retval;
  }

  Future<String> singUpUser(
      String email, String password, String fullName) async {
    String retval = "error";
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _firestore.collection("users").doc(_authResult.user!.uid).set({
        'fullName': fullName,
        'email': _authResult.user!.email,
        'accountCreated': Timestamp.now()
      });

      retval = 'success';
    } on PlatformException catch (e) {
      retval = e.message!;
    } catch (e) {
      print(e);
    }
    return retval;
  }

  Future<String> logInUserWithEmail(String email, String password) async {
    String retval = "error";
    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (_authResult.user != null) {
        //     _currentUser = await OurDataBae().getUserinfo(_authResult.user!.uid);

        // if (_currentUser != null) {
        //   retval = "seccess";
        // }

      } else {
        print('user not created');
      }
    } catch (e) {
      print(e);
    }
    return retval;
  }

  Future<String> logInUserWithGoogle() async {
    String retval = "error";
    GoogleSignIn _googleSignIn = GoogleSignIn(
      // Optional clientId
      // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
      scopes: <String>[
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    try {
      GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication _googleAuth =
          await _googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);

      UserCredential _authResult = await _auth.signInWithCredential(credential);
      if (_authResult.additionalUserInfo!.isNewUser) {
        // OurDataBae().createUser(_user);
      }
      // _currentUser = await OurDataBae().getUserinfo(_authResult.user!.uid);

      // if (_currentUser != null) {
      //   retval = "seccess";
      // }
    } catch (e) {
      print(e);
    }
    return retval;
  }
}
