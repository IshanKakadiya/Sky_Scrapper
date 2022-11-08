// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:currency_converter/model/currency_converter.dart';
import 'package:http/http.dart' as http;

class CurrencyApiHelper {
  CurrencyApiHelper._();
  static final CurrencyApiHelper currencyApiHelper = CurrencyApiHelper._();

  String apiCurrency =
      "https://openexchangerates.org/api/latest.json?app_id=2c67a520bb64440b9348ecaef1243c7c&base=USD";
  String apiCountry = "https://restcountries.com/v3.1/all";

  Future fetchCurrencyData() async {
    http.Response res = await http.get(Uri.parse(apiCurrency));
    http.Response res2 = await http.get(Uri.parse(apiCountry));

    if (res.statusCode == 200) {
      Map<String, dynamic> decodeData = jsonDecode(res.body);

      return decodeData;
    }
  }
}
