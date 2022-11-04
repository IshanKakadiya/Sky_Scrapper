// ignore_for_file: non_constant_identifier_names

class People {
  final String gender;
  final String title;
  final String first;
  final String last;
  final String email;
  final String phone;
  final String username;
  final String password;
  final int age;
  final String dob;
  final String thumbnail;
  final int location_no;
  final String location_name;
  final String location_city;
  final String location_state;
  final String location_country;
  final dynamic location_postcode;

  People({
    required this.gender,
    required this.title,
    required this.first,
    required this.last,
    required this.email,
    required this.username,
    required this.password,
    required this.phone,
    required this.age,
    required this.dob,
    required this.thumbnail,
    required this.location_no,
    required this.location_name,
    required this.location_city,
    required this.location_state,
    required this.location_country,
    required this.location_postcode,
  });

  factory People.fromMap({required Map<String, dynamic> data}) {
    return People(
      phone: data["results"][0]["phone"],
      gender: data["results"][0]["gender"],
      title: data["results"][0]["name"]["title"],
      first: data["results"][0]["name"]["first"],
      last: data["results"][0]["name"]["last"],
      email: data["results"][0]["email"],
      username: data["results"][0]["login"]["username"],
      password: data["results"][0]["login"]["password"],
      age: data["results"][0]["dob"]["age"],
      dob: data["results"][0]["dob"]["date"],
      thumbnail: data["results"][0]["picture"]["large"],
      location_no: data["results"][0]["location"]["street"]["number"],
      location_name: data["results"][0]["location"]["street"]["name"],
      location_city: data["results"][0]["location"]["city"],
      location_state: data["results"][0]["location"]["state"],
      location_country: data["results"][0]["location"]["country"],
      location_postcode: data["results"][0]["location"]["postcode"],
    );
  }
}
