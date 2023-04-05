import 'dart:io';
import 'dart:math';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({super.key, startDate, endDate});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

//MAP CATEGORIES

class _HistoryPageState extends State<HistoryPage> {
  DateTime? startDate = DateTime.now();
  DateTime? endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    void FetchWithDate() {
      print("fetchwithdate");
      //tietokantakutsu startdaten ja enddaten perusteella
      // asetus resultdataan
    }

    FetchWithDate();

    List resultsData = [
      [
        "Groceries",
        [
          ["moi", 60, "2.4."],
          ["moro", 30, "4.4."],
          ["jou", 20, "5.4."]
        ]
      ],
      [
        "Bills",
        [
          ["hei", 560, "3.4."],
          ["jou", 50, "5.4."]
        ]
      ],
      [
        "Car",
        [
          ["moro", 320, "4.4."]
        ]
      ],
      [
        "Funmoney",
        [
          ["jou", 40, "5.4."],
          ["jou", 20, "6.4."]
        ]
      ]
    ];

    Map<String, double> CalcPercentanges() {
      Map<String, double> chartMap = {};
      for (int i = 0; i < resultsData.length; i++) {
        double sum = 0;
        for (var c in resultsData[i][1]) {
          sum += c[1];
        }
        chartMap[resultsData[i][0]] = sum;
      }
      return chartMap;
    }

    DateFormat dateFormat =
        DateFormat.yMMMMd(); // how you want it to be formatted

    return Stack(children: [
      Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(children: [
                  InkWell(
                    child: Text(
                      dateFormat.format(startDate!),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w100,
                          fontFamily: "Hind Siliguri",
                          color: Color(0xff0F5B2E)),
                    ),
                    onTap: () async {
                      DateTime d = DateTime.now();

                      startDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(), //get today's date
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101))
                          .then((value) {
                        setState(() {
                          d = value!;
                        });
                        return value;
                      });
                    },
                  ),
                  Container(
                    child: const Text(
                      " - ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w100,
                          fontFamily: "Hind Siliguri",
                          color: Color(0xff0F5B2E)),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      DateTime d = DateTime.now();

                      endDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(), //get today's date
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101))
                          .then((value) {
                        setState(() {
                          d = value!;
                        });
                        return value;
                      });
                    },
                    child: Text(
                      dateFormat.format(endDate!),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w100,
                          fontFamily: "Hind Siliguri",
                          color: Color(0xff0F5B2E)),
                    ),
                  ),
                ]),
              ),
              Container(
                  padding: EdgeInsets.only(bottom: 50),
                  child: PieChart(
                    dataMap: CalcPercentanges(),
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32,
                    chartRadius: MediaQuery.of(context).size.width / 3.2,
                    initialAngleInDegree: 0,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 32,
                    centerText: "",
                    legendOptions: const LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.right,
                      showLegends: true,
                      legendTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValues: true,
                      showChartValuesInPercentage: false,
                      showChartValuesOutside: false,
                      decimalPlaces: 1,
                    ),
                    // gradientList: ---To add gradient colors---
                    // emptyColorGradient: ---Empty Color gradient---
                  )),
              for (int i = 0; i < resultsData.length; i++) ...[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 3,
                  child: ExpandableTheme(
                    data: const ExpandableThemeData(hasIcon: false),
                    child: ExpandablePanel(
                      header: Expanded(
                        flex: 5,
                        child: Container(
                          //decoration:
                          //BoxDecoration(border: Border.all(width: 1)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  resultsData[i][0].toString(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w100,
                                      fontFamily: "Hind Siliguri",
                                      color: Color(0xff0F5B2E)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      collapsed: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            height: 20,
                            child: Text(resultsData[i][1].length.toString() +
                                " results")),
                      ),
                      expanded: Column(children: [
                        for (var e in resultsData[i][1])
                          Row(children: [
                            for (var ex in e)
                              Expanded(
                                  flex: 4,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        ex.toString(),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w100,
                                            fontFamily: "Hind Siliguri",
                                            color: Color(0xff0F5B2E)),
                                      )))
                          ]),
                      ]),
                    ),
                  ),
                )
              ],
            ],
          ),
        ],
      )
    ]);
  }
}