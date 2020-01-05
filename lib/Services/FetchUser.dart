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

  Future<bool> fetchuser(String email, String password) async {
    Firestore.instance
        .collection('talks')
        .where("topic", isEqualTo: "flutter")
        .snapshots()
        .listen((data) => data.documents.forEach((doc) => print(doc["title"])));

    var body = new Map<String, String>();

    body["usernameOrEmail"] = email;

    body["password"] = password;

    print(body);
    print(json.encode(body));

    print("inside fetch user ----------------------------------");
    try {
      final http.Response response = await http.post(
        'http://192.168.43.238:8080/api/auth/signin',
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      print(response.body);

      final int statusCode = response.statusCode;
      print(statusCode);
      if (statusCode == 200 || statusCode == 201) {
        print('sucees');
        print(response.body);
        final jsonResponse = json.decode(response.body);

        return true;
      } else {
        print("Failed");
        print(statusCode);

        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
