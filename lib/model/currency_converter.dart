// ignore_for_file: non_constant_identifier_names

class Currency {
  final String countryName;
  final Map<String, dynamic> currencies_key;
  final String currencies_flags;

  Currency({
    required this.countryName,
    required this.currencies_flags,
    required this.currencies_key,
  });

  factory Currency.fromMap(Map<String, dynamic> data) {
    return Currency(
      countryName: data["name"]["common"],
      currencies_flags: data["flags"]["svg"],
      currencies_key: data["currencies"],
    );
  }
}
