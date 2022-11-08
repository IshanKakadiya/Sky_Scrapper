// ignore_for_file: unused_local_variable, unnecessary_string_interpolations, unused_label, unnecessary_brace_in_string_interps

import 'package:currency_converter/helper/currency_converter_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:currency_converter/Globle.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String dropdownButton1 = "INR";
  String dropdownButton2 = "USD";
  String iOSpicker1 = "";
  String iOSpicker2 = "";
  int iOSintilizval = 0;
  int iOSintilizva2 = 0;
  String ans = "";
  String iOSans = "";
  String extraData = "";
  String iOSextraData = "";
  List spiltData = [];
  List iOSspiltData = [];

  GlobalKey<FormState> amountKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();
  TextEditingController iOSamountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return (Globle.isIOS)
        ? MaterialApp(
            darkTheme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: const Text("Currency Converter"),
                centerTitle: true,
                actions: [
                  Switch(
                    value: Globle.isIOS,
                    onChanged: (val) {
                      setState(() {
                        Globle.isIOS = val;
                      });
                    },
                  ),
                ],
              ),
              body: FutureBuilder(
                future: CurrencyApiHelper.currencyApiHelper.fetchCurrencyData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("ERROR : ${snapshot.error}"),
                    );
                  } else if (snapshot.hasData) {
                    Map<String, dynamic> currencyData = snapshot.data;
                    Map rates = currencyData["rates"];

                    return ListView(
                      padding: const EdgeInsets.all(25),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Form(
                          key: amountKey,
                          child: TextFormField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (amountController.text.isEmpty) {
                                return "Enter Number After Convert";
                              } else if (10 < amountController.text.length) {
                                return "Valid Amount Length 10 , Your Amount ${amountController.text.length}";
                              }

                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(","),
                              FilteringTextInputFormatter.deny("-"),
                              FilteringTextInputFormatter.deny(" "),
                            ],
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter Amount",
                              label: Text("Amount"),
                            ),
                          ),
                        ),
                        const SizedBox(height: 7),
                        DropdownButton<String>(
                          items: rates.keys.map((val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          }).toList(),
                          value: dropdownButton1,
                          elevation: 16,
                          onChanged: (val) {
                            setState(() {
                              dropdownButton1 = val!;
                            });
                          },
                        ),
                        DropdownButton<String>(
                          items: rates.keys.map((val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          }).toList(),
                          value: dropdownButton2,
                          elevation: 16,
                          onChanged: (val) {
                            setState(() {
                              dropdownButton2 = val!;
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          child: const Text("Convert"),
                          onPressed: () {
                            if (amountKey.currentState!.validate()) {
                              String textController = amountController.text;
                              String value = (double.parse(textController) /
                                      rates[dropdownButton1] *
                                      rates[dropdownButton2])
                                  .toStringAsFixed(3)
                                  .toString();

                              ans =
                                  "${amountController.text} $dropdownButton1 = $value $dropdownButton2";

                              // extraData = (dropdownButton2 != "USD")
                              //     ? "1 $dropdownButton1 = ${rates[dropdownButton2].toStringAsFixed(2)} $dropdownButton2"
                              //     : "1 $dropdownButton1 = 0.01 $dropdownButton2";

                              String data = (1 /
                                      rates[dropdownButton1] *
                                      rates[dropdownButton2])
                                  .toStringAsFixed(4)
                                  .toString();

                              extraData =
                                  "1 $dropdownButton1 = $data $dropdownButton2";

                              spiltData = ans.split(" ");

                              setState(() {});
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        (amountController.text.isNotEmpty)
                            ? Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                ),
                                alignment: Alignment.center,
                                child: RichText(
                                  text: TextSpan(
                                    text: spiltData[0],
                                    style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: " ${spiltData[1]} ",
                                        style: GoogleFonts.openSans(
                                          color: Colors.white.withOpacity(0.7),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "= ${spiltData[3]}",
                                        style: GoogleFonts.openSans(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17,
                                        ),
                                      ),
                                      TextSpan(
                                        text: " ${spiltData[4]}",
                                        style: GoogleFonts.openSans(
                                          color: Colors.white.withOpacity(0.7),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                        const SizedBox(height: 10),
                        (amountController.text.isNotEmpty)
                            ? Row(
                                children: [
                                  const Spacer(),
                                  Text("* $extraData"),
                                ],
                              )
                            : Container(),
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          )
        : CupertinoApp(
            debugShowCheckedModeBanner: false,
            home: CupertinoPageScaffold(
              resizeToAvoidBottomInset: false,
              navigationBar: CupertinoNavigationBar(
                middle: const Text(
                  "Currency Converter",
                ),
                trailing: CupertinoSwitch(
                  value: Globle.isIOS,
                  onChanged: (val) {
                    setState(() {
                      Globle.isIOS = val;
                    });
                  },
                ),
              ),
              child: FutureBuilder(
                future: CurrencyApiHelper.currencyApiHelper.fetchCurrencyData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("ERROR : ${snapshot.error}"),
                    );
                  } else if (snapshot.hasData) {
                    Map<String, dynamic> currencyData = snapshot.data;
                    Map rates = currencyData["rates"];

                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          const SizedBox(height: 100),
                          Form(
                            key: amountKey,
                            child: Column(
                              children: [
                                CupertinoTextFormFieldRow(
                                  cursorColor: Colors.white,
                                  placeholder: "Enter Your Amount",
                                  controller: iOSamountController,
                                  keyboardType: TextInputType.number,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                  ),
                                  validator: (val) {
                                    if (iOSamountController.text.isEmpty) {
                                      return "Enter Number After Convert";
                                    } else if (10 <
                                        iOSamountController.text.length) {
                                      return "Valid Amount Length 10 , Your Amount ${iOSamountController.text.length}";
                                    } else if (iOSpicker1 == "" ||
                                        iOSpicker2 == "") {
                                      return "Please Chose Currency . .";
                                    }

                                    return null;
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(","),
                                    FilteringTextInputFormatter.deny("-"),
                                    FilteringTextInputFormatter.deny(" "),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                Container(
                                  height: 55,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: CupertinoButton(
                                    padding: const EdgeInsets.all(0),
                                    child: Text(
                                      (iOSpicker1 == "")
                                          ? "-   Chose Currency   -"
                                          : "${iOSpicker1}",
                                      style: GoogleFonts.openSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 22,
                                      ),
                                    ),
                                    onPressed: () {
                                      showCupertinoModalPopup(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (context) {
                                            return Container(
                                              height: 500,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              child: CupertinoPicker(
                                                scrollController:
                                                    FixedExtentScrollController(
                                                  initialItem: iOSintilizval,
                                                ),
                                                itemExtent: 35,
                                                children: rates.keys.map((val) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: val,
                                                    alignment: Alignment.center,
                                                    child: Text(val),
                                                  );
                                                }).toList(),
                                                onSelectedItemChanged: (val) {
                                                  List data =
                                                      rates.keys.toList();
                                                  setState(() {
                                                    iOSintilizval =
                                                        data.indexOf(data[val]);
                                                    iOSpicker1 = data[val];
                                                  });
                                                },
                                              ),
                                            );
                                          });
                                    },
                                  ),
                                ),
                                const SizedBox(height: 15),
                                const Icon(
                                  Icons.arrow_downward_outlined,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                const SizedBox(height: 15),
                                Container(
                                  height: 55,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: CupertinoButton(
                                    padding: const EdgeInsets.all(0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      (iOSpicker2 == "")
                                          ? "-   Chose Currency   -"
                                          : "${iOSpicker2}",
                                      style: GoogleFonts.openSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 22,
                                      ),
                                    ),
                                    onPressed: () {
                                      showCupertinoModalPopup(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (context) {
                                            return Container(
                                              height: 500,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: CupertinoPicker(
                                                scrollController:
                                                    FixedExtentScrollController(
                                                  initialItem: iOSintilizva2,
                                                ),
                                                itemExtent: 35,
                                                children: rates.keys.map((val) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: val,
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      val,
                                                    ),
                                                  );
                                                }).toList(),
                                                onSelectedItemChanged: (val) {
                                                  List data =
                                                      rates.keys.toList();
                                                  setState(() {
                                                    iOSintilizva2 =
                                                        data.indexOf(data[val]);
                                                    iOSpicker2 = data[val];
                                                  });
                                                },
                                              ),
                                            );
                                          });
                                    },
                                  ),
                                ),
                                const SizedBox(height: 25),
                                Container(
                                  height: 50,
                                  width: 250,
                                  child: CupertinoButton(
                                    padding: const EdgeInsets.all(0),
                                    alignment: Alignment.center,
                                    color: Colors.white,
                                    child: Text(
                                      "Convert",
                                      style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 22,
                                      ),
                                    ),
                                    onPressed: () {
                                      if (amountKey.currentState!.validate()) {
                                        String textController =
                                            iOSamountController.text;
                                        String value =
                                            (double.parse(textController) /
                                                    rates[iOSpicker1] *
                                                    rates[iOSpicker2])
                                                .toStringAsFixed(3)
                                                .toString();

                                        iOSans =
                                            "${iOSamountController.text} $iOSpicker1 = $value $iOSpicker2";

                                        String data = (1 /
                                                rates[iOSpicker1] *
                                                rates[iOSpicker2])
                                            .toStringAsFixed(4)
                                            .toString();

                                        iOSextraData =
                                            "1 $iOSpicker1 = $data $iOSpicker2";

                                        iOSspiltData = iOSans.split(" ");

                                        setState(() {});
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(height: 25),
                                (iOSspiltData.isNotEmpty)
                                    ? Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        alignment: Alignment.center,
                                        child: RichText(
                                          text: TextSpan(
                                            text: iOSspiltData[0],
                                            style: GoogleFonts.openSans(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: " ${iOSspiltData[1]} ",
                                                style: GoogleFonts.openSans(
                                                  color: Colors.white
                                                      .withOpacity(0.7),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 17,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "= ${iOSspiltData[3]}",
                                                style: GoogleFonts.openSans(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 17,
                                                ),
                                              ),
                                              TextSpan(
                                                text: " ${iOSspiltData[4]}",
                                                style: GoogleFonts.openSans(
                                                  color: Colors.white
                                                      .withOpacity(0.7),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(),
                                const SizedBox(height: 10),
                                (iOSspiltData.isNotEmpty)
                                    ? Row(
                                        children: [
                                          const Spacer(),
                                          Text(
                                            "* $iOSextraData",
                                            style: GoogleFonts.openSans(
                                              color:
                                                  Colors.white.withOpacity(0.7),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                },
              ),
            ),
          );
  }
}
