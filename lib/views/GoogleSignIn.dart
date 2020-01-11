import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class GSignIn extends StatefulWidget {
  static const String id = "Goolgle";
  @override
  State createState() => GSignInState();
}

class GSignInState extends State<GSignIn> {
  GoogleSignInAccount _currentUser;

  @override
  void initState() {
    super.initState();
    print('chek user?');
    if (this.mounted) {
      setState(() {
        _googleSignIn.disconnect();
        _googleSignIn.onCurrentUserChanged
            .listen((GoogleSignInAccount account) {
          _currentUser = account;
        });
        _googleSignIn.signInSilently();
        _handleSignIn();
      });
    }
  }

  Future<void> _handleSignIn() async {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      if (this.mounted) {
        setState(() {
          _currentUser = account;
        });
      }
      if (_currentUser != null) {
        //_handleGetContact();
        print('User logged');
      } else {
        print('No User Found');
      }
    });
    _googleSignIn.signInSilently();
    try {
      //await _googleSignIn.signIn();
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
    } catch (e) {
      print(e);
    }
  }

  Future<void> _handleSignOut() async {
    await _googleSignIn.signOut();
    //await _googleSignIn.disconnect();
    Navigator.pop(context);
  }

  Widget _buildBody() {
    if (_currentUser != null) {
      print('user here');
      String imgurlFullzize = _currentUser.photoUrl + '?sz=300';

      return Stack(children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/back.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 60, 40, 20),
              child: Container(
                width: 150.0,
                height: 150.0,
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(imgurlFullzize),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            new Text(
              'Welcome',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              _currentUser.displayName.toString(),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Email:",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  _currentUser.email.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "UserID:",
                  style: TextStyle(color: Colors.white),
                ),
                Text(_currentUser.id.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    )),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.white)),
                    color: Colors.blue,
                    child: const Text('DASHBOARD'),
                    onPressed: () async {
                      Navigator.of(context).pushNamed("/dashboard");
                    },
                  ),
                  RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.grey)),
                    child: const Text('SIGN OUT'),
                    onPressed: _handleSignOut, //me functon eka ehata
                  ),
                ],
              ),
            ),
          ],
        ),
      ]);
    } else {
      return Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/back.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: new Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(height: 10.0),
                Text(
                  "Please Wait",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Google Sign In'),
        // ),
        body: ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: _buildBody(),
    ));
  }
}
