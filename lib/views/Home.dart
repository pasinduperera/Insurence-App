import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _login() {
    return Container(
      width: 200.0,
      child: new Padding(
        padding: const EdgeInsets.only(
            top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: new MaterialButton(
            splashColor: Colors.white,
            child: Text(
              "Login",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/login');
            },
            minWidth: double.infinity,
            height: 48.0,
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }

  Widget _register() {
    return Container(
      width: 200.0,
      child: new Padding(
        padding: const EdgeInsets.only(
            top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: new MaterialButton(
            splashColor: Colors.white,
            elevation: 10,
            child: Text(
              "Register",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/registration');
            },
            minWidth: double.infinity,
            height: 48.0,
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }

  Widget _aboutus() {
    return Container(
      width: 200.0,
      child: new Padding(
        padding: const EdgeInsets.only(
            top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: new MaterialButton(
            splashColor: Colors.white,
            child: Text(
              "About us",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/aaa');
            },
            minWidth: double.infinity,
            height: 48.0,
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }

  // DecorationImage _buildbackgroundImage() {
  //   return DecorationImage(
  //     fit: BoxFit.cover,
  //     colorFilter:
  //         ColorFilter.mode(Colors.black.withOpacity(1), BlendMode.dstATop),
  //     image: AssetImage('assets/Images/back.jpg'),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     title:
      //         //Text(model.title),
      //         AutoSizeText(
      //   model.title,
      //   style: TextStyle(fontSize: 20),
      //   maxLines: 1,
      // )),
      body: Container(
        alignment: Alignment.center,
        // decoration: BoxDecoration(
        //   image: _buildbackgroundImage(),
        // ),
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 200.0,
                  width: 200.0,
                  child: new Image.asset('assets/logo.png'),
                ),
                SizedBox(height: 25.0),
                _login(),
                _register(),
                _aboutus(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
