// ignore_for_file: unused_local_variable, unused_element

import 'package:covid_19_app/helper/covid_helper.dart';
import 'package:covid_19_app/model/covid.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  dynamic country;
  List countryName = [];
  int i = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("COVID-19 APP"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: CovidApiHelper.covidApiHelper.feachCovidData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR : ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List covidData = snapshot.data;
            countryName = covidData.map((e) => e.country).toList();

            totalData({required String title, required String value}) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      title,
                      style: GoogleFonts.openSans(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value,
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: DropdownButton(
                        value: country,
                        hint: const Text("Please Select Country."),
                        onChanged: (val) {
                          setState(() {
                            country = val;
                            i = countryName.indexOf(val);
                          });
                        },
                        items: covidData.map((e) {
                          return DropdownMenuItem(
                            value: e.country,
                            child: Row(
                              children: [
                                Text(
                                  e.country,
                                  style: GoogleFonts.openSans(),
                                ),
                                const SizedBox(width: 10),
                                Image.network(e.flag, height: 15),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 14,
                    child: (i >= 0)
                        ? ListView(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(10),
                            children: [
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    covidData[i].flag,
                                    height: 80,
                                    width: 110,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.52,
                                        child: Text(
                                          "${covidData[i].country}",
                                          overflow: TextOverflow.visible,
                                          style: GoogleFonts.openSans(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        covidData[i].continent,
                                        style: GoogleFonts.openSans(
                                          fontSize: 18,
                                          color: Colors.white.withOpacity(0.8),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "Population : ${covidData[i].population}",
                                        style: GoogleFonts.openSans(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  totalData(
                                    title: "Total Cases",
                                    value: "${covidData[i].cases}",
                                  ),
                                  totalData(
                                    title: "Total Deaths",
                                    value: "${covidData[i].deaths}",
                                  )
                                ],
                              ),
                              const SizedBox(height: 17),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  totalData(
                                    title: "Total Recovered",
                                    value: "${covidData[i].recovered}",
                                  ),
                                  totalData(
                                    title: "Total Tests",
                                    value: "${covidData[i].tests}",
                                  )
                                ],
                              ),
                              const SizedBox(height: 17),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  totalData(
                                    title: "Active Cases",
                                    value: "${covidData[i].active}",
                                  ),
                                ],
                              ),
                              const Divider(
                                height: 50,
                                color: Colors.white,
                                thickness: 0.8,
                              ),
                              totalData(
                                title: "One Case-Per-People",
                                value: "${covidData[i].oneCasePerPeople}",
                              ),
                              const SizedBox(height: 17),
                              totalData(
                                title: "One Death-Per-People",
                                value: "${covidData[i].oneDeathPerPeople}",
                              ),
                              const SizedBox(height: 17),
                              totalData(
                                title: "Recovered-Per-One_Million",
                                value: "${covidData[i].recoveredPerOneMillion}",
                              ),
                              const SizedBox(height: 17),
                              totalData(
                                title: "One Test-Per-People",
                                value: "${covidData[i].oneTestPerPeople}",
                              ),
                              const SizedBox(height: 17),
                              totalData(
                                title: "Active-Per-One-Million",
                                value: "${covidData[i].activePerOneMillion}",
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Spacer(),
                              Text(
                                "Please First Select Country",
                                style: GoogleFonts.openSans(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Divider(
                                height: 35,
                                color: Colors.white,
                                indent: 40,
                                endIndent: 40,
                                thickness: 1,
                              ),
                              const Icon(Icons.remove_red_eye),
                              const Spacer(),
                              const Divider(
                                height: 35,
                                color: Colors.white,
                                indent: 90,
                                endIndent: 90,
                                thickness: 1,
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
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
