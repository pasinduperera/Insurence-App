import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:insure_app/model/User.dart';

class FetchUser with ChangeNotifier {
  User _user;

  User getUser() {
    return this._user;
  }

  setUser(User u) {
    _user = u;
    notifyListeners();
  }

  Future<bool> fetchuser(String name, String password) async {
    var document = await Firestore.instance
        .collection('Users')
        .where("name", isEqualTo: name)
        .where("password", isEqualTo: password)
        .getDocuments();

    if (document.documents.isEmpty) {
      print('no documents found');
      setUser(null);
      notifyListeners();
      return false;
    } else {
      print("dataaaaaa");
      print(document.documents.elementAt(0).data);
      User p = User.fromJson(document.documents.elementAt(0).data);
      setUser(p);

      return true;
    }
  }
}
