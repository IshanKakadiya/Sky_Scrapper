// ignore_for_file: unused_local_variable, no_leading_underscores_for_local_identifiers, unused_element

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rendom_people/model/people.dart';
import 'package:rendom_people/people_helper/people_helper.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Random People Data"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: FutureBuilder(
        future: PeopleApiHelper.peopleApiHelper.fetchPeopleData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR : ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            People? peopleData = snapshot.data;
            String dob = peopleData!.dob;
            final res = dob.split("T");
            final maindob = res[0].split("-");

            totalData({required String title, required String value}) {
              return Container(
                width: _width * 0.46,
                padding: const EdgeInsets.only(left: 5, right: 5),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 1.2,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                clipBehavior: Clip.hardEdge,
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    RichText(
                      text: TextSpan(
                        text: "$title : ",
                        style: GoogleFonts.openSans(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 17,
                        ),
                        children: [
                          TextSpan(
                            text: value,
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              );
            }

            return Container(
              height: _height,
              width: _width,
              margin: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 15,
                bottom: 15,
              ),
              decoration: BoxDecoration(
                // color: Colors.white.withOpacity(0.7),
                border: Border.all(color: Colors.white, width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(peopleData.thumbnail),
                          ),
                        ),
                      ),
                      // CircleAvatar(
                      //   radius: 70,
                      //   backgroundImage: NetworkImage(peopleData!.thumbnail),
                      // ),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          totalData(
                            title: "DOB",
                            value: "${maindob[2]}/${maindob[1]}/${maindob[0]}",
                          ),
                          const SizedBox(height: 8),
                          totalData(
                            title: "Age",
                            value: "${peopleData.age}",
                          ),
                          const SizedBox(height: 8),
                          totalData(
                            title: "Gender",
                            value: peopleData.gender,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  totalData(
                    title: "Name",
                    value:
                        "${peopleData.title} ${peopleData.first} ${peopleData.last}",
                  ),
                  const SizedBox(height: 10),
                  totalData(title: "User-Name", value: peopleData.username),
                  const SizedBox(height: 10),
                  totalData(title: "Password", value: peopleData.password),
                  const SizedBox(height: 10),
                  totalData(title: "Email", value: peopleData.email),
                  const SizedBox(height: 10),
                  totalData(title: "Phone", value: peopleData.phone),
                  const SizedBox(height: 10),
                  totalData(
                    title: "Street No",
                    value: "${peopleData.location_no}",
                  ),
                  const SizedBox(height: 10),
                  totalData(
                    title: "Street Name",
                    value: peopleData.location_name,
                  ),
                  const SizedBox(height: 10),
                  totalData(
                    title: "City",
                    value: peopleData.location_city,
                  ),
                  const SizedBox(height: 10),
                  totalData(
                    title: "State",
                    value: peopleData.location_state,
                  ),
                  const SizedBox(height: 10),
                  totalData(
                    title: "Country",
                    value: peopleData.location_country,
                  ),
                  const SizedBox(height: 10),
                  totalData(
                    title: "Pincode",
                    value: "${peopleData.location_postcode}",
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
