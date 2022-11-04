class Covid {
  final String country;
  final String flag;
  final String continent;
  final num cases;
  final num oneCasePerPeople;
  final num deaths;
  final num oneDeathPerPeople;
  final num recovered;
  final num recoveredPerOneMillion;
  final num tests;
  final num oneTestPerPeople;
  final num active;
  final num activePerOneMillion;
  final num population;

  Covid({
    required this.country,
    required this.flag,
    required this.continent,
    required this.cases,
    required this.oneCasePerPeople,
    required this.deaths,
    required this.oneDeathPerPeople,
    required this.recovered,
    required this.recoveredPerOneMillion,
    required this.tests,
    required this.oneTestPerPeople,
    required this.active,
    required this.activePerOneMillion,
    required this.population,
  });

  factory Covid.fromMap({required Map<String, dynamic> data}) {
    return Covid(
      country: data["country"],
      flag: data['countryInfo']['flag'],
      continent: data["continent"],
      cases: data["cases"],
      oneCasePerPeople: data["oneCasePerPeople"],
      deaths: data["deaths"],
      oneDeathPerPeople: data["oneDeathPerPeople"],
      recovered: data["recovered"],
      recoveredPerOneMillion: data["recoveredPerOneMillion"],
      tests: data["tests"],
      oneTestPerPeople: data["oneTestPerPeople"],
      active: data["active"],
      activePerOneMillion: data["activePerOneMillion"],
      population: data["population"],
    );
  }
}
