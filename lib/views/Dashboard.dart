import 'package:flutter/material.dart';
import 'package:insure_app/Services/FetchUser.dart';
import 'package:insure_app/model/User.dart';
import 'package:provider/provider.dart';

class Dashbord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var users = Provider.of<FetchUser>(context);
    User user = users.getUser();

    return Scaffold(
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // AppBar(
              //   automaticallyImplyLeading: false,
              //   title: Text('Choose'),
              // ),
              // new DrawerHeader(
              //   child: new Text("DRAWER HEADER.."),
              //   //decoration: new BoxDecoration(color: Colors.white),
              // ),
              UserAccountsDrawerHeader(
                  accountName: Text(user.name),
                  accountEmail: Text(user.email),
                  currentAccountPicture: CircleAvatar(
                    radius: 5.0,
                    backgroundImage: NetworkImage(user.image),
                    backgroundColor: Colors.white,
                  )
                  //
                  //CircleAvatar(
                  //   backgroundColor:
                  //       Theme.of(context).platform == TargetPlatform.iOS
                  //           ? Colors.blue
                  //           : Colors.white,
                  //   child: Text(
                  //     "A",
                  //     style: TextStyle(fontSize: 40.0),
                  //   ),
                  // ),
                  ),
              ListTile(
                leading: Icon(Icons.arrow_forward_ios),
                title: Text('All Instruments'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.map),
                title: Text('Search By Map'),
                onTap: () {
                  Navigator.of(context).pushNamed('/gmap');
                },
              ),
              ListTile(
                  leading: Icon(Icons.money_off),
                  title: Text('Payment History'),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   new MaterialPageRoute(
                    //       builder: (BuildContext context) =>
                    //           new Payment("title", "url", "name", "email")),
                    // );
                  }),
              ListTile(
                leading: Icon(Icons.people),
                title: Text('Profile'),
                // onTap: () async {
                //   var userauth = await _auth.currentUser();

                //   if (userauth != null) {
                //     print("You cannot change the profile");
                //     showDialog(
                //         context: context,
                //         builder: (BuildContext context) {
                //           return AlertDialog(
                //             title: new Text("Cannot Edit the Profile"),
                //             content: new Text(
                //                 "We are sorry.This feture is not allowed for google and facebook athentification"),
                //             actions: <Widget>[
                //               new FlatButton(
                //                 child: new Text("Close"),
                //                 onPressed: () {
                //                   Navigator.of(context).pop();
                //                 },
                //               ),
                //             ],
                //           );
                //         });
                //   } else {
                //     Navigator.push(
                //       context,
                //       new MaterialPageRoute(
                //         builder: (BuildContext context) =>
                //             new ProfileManagement(
                //           user: user,
                //         ),
                //       ),
                //     );
                //   }
                // },
              ),
              ListTile(
                leading: Icon(Icons.chat),
                title: Text('Chat'),
                onTap: () {
                  Navigator.of(context).pushNamed('/chatScreen');
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Setings'),
                onTap: () {
                  Navigator.of(context).pushNamed('/settings');
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () {
                  //handleLogOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/Home', (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('All Instruments...'),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: () {
          //     products.setProductTempList(products.getProductList());
          //     showSearch(context: context, delegate: DataSearch());
          //   },
          // )
        ],
      ),
      body: Container(
        child: Text("Welcomeeeeeeee"),
      ),
    );
  }

  // void handleLogOut() {
  //   _auth.signOut();
  // }
}
