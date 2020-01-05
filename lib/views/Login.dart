import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:insure_app/Services/FetchUser.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<Login> {
  final formkey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String email;
  String password;
  int _state = 0;

  Future<bool> validateAndSave(FetchUser fetching) async {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      print('Form is Valid');
      print(email);
      print(password);
      bool x = await fetching.fetchuser(email, password);
      print(x);
      if (x) {
        print(fetching.getUser().name);
        // print(fetching.getUser().username);
        // bool y = await products.fetchProductList(tokenM);
        //   if (y) {
        //     // print(products.getProductList().photos[0].title);
        //     // print(products.getProductList().photos[0].id);
        //     form.reset();

        //     setState(() {
        //       _state = 2;
        //     });
        //     Navigator.of(context).pushNamed('/dashboard');
        //   } else {
        //     print("no data");
        //   }

        //   return true;
        // } else {
        //   print("no user");
        //   setState(() {
        //     _state = 0;
        //   });
        //   _showSnackBar();
        //   return false;
        // }
      } else {
        print('Form is Null');
        setState(() {
          _state = 0;
        });
        return false;
      }
    }
  }

  DecorationImage _buildbackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(1), BlendMode.dstATop),
      image: AssetImage('assets/Images/back.jpg'),
    );
  }

  Widget _usernameTF() {
    return TextFormField(
      style: TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
          icon: const Icon(
            Icons.person,
            color: Colors.blue,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          labelStyle: TextStyle(color: Colors.blue, letterSpacing: 1.5),
          hintStyle: TextStyle(letterSpacing: 1.3),
          labelText: 'User Name',
          filled: true,
          fillColor: Colors.transparent),
      validator: (value) => value.isEmpty ? 'User Name Can\'t be empty' : null,
      onSaved: (String value) {
        email = value;
      },
    );
  }

  Widget _passwordTF() {
    return TextFormField(
      style: TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
          // border: OutlineInputBorder(
          //     gapPadding: 0.0,
          //     borderRadius: BorderRadius.circular(1.5)
          // )
          icon: const Icon(
            Icons.security,
            color: Colors.blue,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          labelStyle: TextStyle(color: Colors.blue, letterSpacing: 1.5),
          hintStyle: TextStyle(letterSpacing: 1.3),
          labelText: 'Password',
          filled: true,
          fillColor: Colors.transparent),
      obscureText: true,
      validator: (value) => value.isEmpty ? 'Password Can\'t be empty' : null,
      onSaved: (String value) {
        password = value;
      },
    );
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        "LOGIN",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  Widget _newSaveButton(FetchUser fetching) {
    return Container(
      width: 200.0,
      child: new Padding(
        padding: const EdgeInsets.only(
            top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: new MaterialButton(
            splashColor: Colors.white,
            child: setUpButtonChild(),
            onPressed: () {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              setState(() {
                _state = 1;
              });
              this.validateAndSave(fetching);
            },
            minWidth: double.infinity,
            height: 48.0,
            color: Colors.lightGreen,
          ),
        ),
      ),
    );
  }

  Widget _loginGoogle() {
    return SignInButton(
      Buttons.Google,
      text: "Sign up with Google",
      onPressed: () {
        Navigator.of(context).pushNamed('/google');
      },
    );
  }

  Widget _register() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'New to the APP ?',
            style: TextStyle(fontFamily: 'Montserrat', color: Colors.purple),
          ),
          SizedBox(width: 5.0),
          GestureDetector(
              child: Text(
                "Register",
                style: TextStyle(
                    color: Colors.green,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/registration');
              })
        ],
      ),
    );
  }

  _showSnackBar() {
    print("Show Snackbar here !");
    final snackBar = new SnackBar(
      content: new Text("Login Failed...!!!"),
      duration: new Duration(seconds: 3),
      backgroundColor: Colors.red,
      action: new SnackBarAction(
          label: 'Try Again',
          onPressed: () {
            print('press Ok on SnackBar');
          }),
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 450.0 : deviceWidth * 0.95;
    var fetching = Provider.of<FetchUser>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: _buildbackgroundImage(),
          ),
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0),
                width: targetWidth,
                child: Form(
                  key: formkey,
                  child: Column(
                    children: <Widget>[
                      _usernameTF(),
                      SizedBox(
                        height: 15.0,
                      ),
                      _passwordTF(),
                      SizedBox(height: 5.0),
                      SizedBox(
                        height: 20.0,
                      ),
                      _newSaveButton(fetching),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            _loginGoogle(),
                            SizedBox(
                              height: 10.0,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                          ],
                        ),
                      ),
                      _register()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
