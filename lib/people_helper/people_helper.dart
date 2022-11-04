// ignore_for_file: unused_local_variable, body_might_complete_normally_nullable

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rendom_people/model/people.dart';

class PeopleApiHelper {
  PeopleApiHelper._();
  static final PeopleApiHelper peopleApiHelper = PeopleApiHelper._();

  String api = "https://randomuser.me/api/";

  Future<People?> fetchPeopleData() async {
    http.Response res = await http.get(Uri.parse(api));

    if (res.statusCode == 200) {
      Map<String, dynamic> decodeData = jsonDecode(res.body);

      People people = People.fromMap(data: decodeData);

      return people;
    }
  }
}
