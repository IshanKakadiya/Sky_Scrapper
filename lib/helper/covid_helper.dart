// ignore_for_file: unused_local_variable, body_might_complete_normally_nullable

import 'package:covid_19_app/model/covid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CovidApiHelper {
  CovidApiHelper._();
  static final CovidApiHelper covidApiHelper = CovidApiHelper._();

  final String api = "https://disease.sh/v3/covid-19/countries";

  Future feachCovidData() async {
    http.Response res = await http.get(Uri.parse(api));

    if (res.statusCode == 200) {
      List decodeData = jsonDecode(res.body);

      List<Covid> covid =
          decodeData.map((e) => Covid.fromMap(data: e)).toList();

      return covid;
    }
  }
}
