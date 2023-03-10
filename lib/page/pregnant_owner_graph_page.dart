import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:last_ocr/functions/functions.dart';

late double mating_week1 = 18;
late double mating_week2 = 20;
late double mating_week3 = 35;
late double mating_week4 =29;
late double mating_goal = 32;

late double feedbaby_week1 = 24;
late double feedbaby_week2 = 35;
late double feedbaby_week3 = 29;
late double feedbaby_week4 = 18;
late double feedbaby_goal = 27;

late double mortality_week1 = 11;
late double mortality_week2 = 24;
late double mortality_week3 = 32;
late double mortality_week4 = 37;
late double mortality_goal = 35;

late double shipment_week1 = 14;
late double shipment_week2 = 21;
late double shipment_week3 = 32;
late double shipment_week4 = 29;
late double shipment_goal = 35;

List<String> list = <String>['2021', '2022', '2023', '2024'];
List<String> list2 = <String>['1', '2', '3', '4','5','6','7','8','9','10','11','12'];

class PregnantOwnerGraphPage extends StatefulWidget {
  static const routeName = '/camera-page';

  const PregnantOwnerGraphPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  PregnantOwnerGraphPageState createState() => PregnantOwnerGraphPageState();
}

class PregnantOwnerGraphPageState extends State<PregnantOwnerGraphPage> {

  var thisyear = DateTime.now().year;
  var thismonth = DateTime.now().month;

  void increase_month(){
    setState(() {
      thismonth++;
      if(thismonth>12) {
        thismonth = 1;
        thisyear++;
      }
    });
  }
  void decrease_month(){
    setState(() {
      thismonth--;
      if(thismonth<1) {
        thismonth = 12;
        thisyear--;
      }
    });
  }

  List list_mating = [
    mating_week1,
    mating_week2,
    mating_week3,
    mating_week4,
    mating_goal
  ];
  List lsit_feedbaby = [
    feedbaby_week1,
    feedbaby_week2,
    feedbaby_week3,
    feedbaby_week4,
    feedbaby_goal
  ];
  List list_mortality = [
    mortality_week1,
    mortality_week2,
    mortality_week3,
    mortality_week4,
    mortality_goal
  ];
  List list_shipment = [
    shipment_week1,
    shipment_week2,
    shipment_week3,
    shipment_week4,
    shipment_goal
  ];

  final goal_Controller_cross = TextEditingController();
  final goal_Controller_sevrer = TextEditingController();
  final goal_Controller_total = TextEditingController();
  final goal_Controller_feed = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ocrTargetSelectedRow(thisyear.toString(), thismonth.toString());

    return Scaffold(
        appBar: AppBar(
            title: Text("????????? ?????????")
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 50),
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () { decrease_month();}, icon: Icon(Icons.navigate_before)
                    ),
                    Text('$thisyear'.toString()+"??? "+'$thismonth'.toString()+"???",style: TextStyle(fontSize: 25),),
                    IconButton(
                        onPressed: () { increase_month();}, icon: Icon(Icons.navigate_next)
                    )
                  ]
              ),
              Column(
                children: [
                  Text("??????", style: TextStyle(fontSize: 20),),
                  AspectRatio(aspectRatio: 3 / 2,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 30, 30),
                      child: LineChart(
                        mainChart_sow_cross(),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text("??????", style: TextStyle(fontSize: 20),),
                  AspectRatio(aspectRatio: 3 / 2,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 30, 30),
                      child: LineChart(
                        mainChart_sow_sevrer(),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text("????????????", style: TextStyle(fontSize: 20),),
                  AspectRatio(aspectRatio: 3 / 2,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 30, 30),
                      child: LineChart(
                        mainChart_total_baby(),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text("??????", style: TextStyle(fontSize: 20),),
                  AspectRatio(aspectRatio: 3 / 2,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 30, 30),
                      child: LineChart(
                        mainChart_feed_baby(),
                      ),
                    ),
                  ),
                ],
              ),
              // Stack(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   alignment: Alignment.bottomLeft,
              //   children: [
              //     FloatingActionButton(
              //       child: Icon(Icons.cached_outlined ),
              //       onPressed: () {
              //
              //       },
              //     )
              //   ],
              // )

            ],
          ),
        ),
        floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: 'replay',
                backgroundColor: Colors.blue,
                child: Icon(Icons.refresh),
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => PregnantOwnerGraphPage()));

                  //setState(() {});
                },
              ),
              FloatingActionButton(
                  heroTag: 'dialog',
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.arrow_forward),
                  onPressed: () async {
                    showDialog(context: context, barrierDismissible: true, builder: (context) {
                      // return Expanded(
                      return AlertDialog(
                          scrollable: true,
                          title: Text("???????????? ??????????????????"),
                          content:
                          Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(children:<Widget>[
                                  Text(thisyear.toString()+"??? "+thismonth.toString()+"???")
                                ]),
                                Row(children:<Widget>[
                                  Text("??????  "),
                                  SizedBox(width: 10,),
                                  SizedBox(width:50,child:TextField(
                                    decoration: InputDecoration(
                                      hintText: '',),
                                    textAlign: TextAlign.left,
                                    keyboardType: TextInputType.number,
                                    controller: goal_Controller_cross,
                                  ))]),
                                Row(children:<Widget>[
                                  Text("??????  "),
                                  SizedBox(width: 10,),
                                  SizedBox(width:50,child:TextField(
                                    decoration: InputDecoration(hintText: '',),
                                    textAlign: TextAlign.left,
                                    keyboardType: TextInputType.number,
                                    controller: goal_Controller_sevrer,
                                  ))]),
                                Row(children:<Widget>[
                                  Text("??????  "),
                                  SizedBox(width: 10,),
                                  SizedBox(width:50,child:TextField(
                                    decoration: InputDecoration(hintText: '',),
                                    textAlign: TextAlign.left,
                                    keyboardType: TextInputType.number,
                                    controller: goal_Controller_total,
                                  ))]),
                                Row(children:<Widget>[
                                  Text("??????  "),
                                  SizedBox(width: 10,),
                                  SizedBox(width:50,child:TextField(
                                    decoration: InputDecoration(hintText: '',),
                                    textAlign: TextAlign.left,
                                    keyboardType: TextInputType.number,
                                    controller: goal_Controller_feed,
                                  ))]),
                              ]),
                          actions: <Widget>[
                            ButtonBar(
                                alignment: MainAxisAlignment.end,
                                buttonPadding: EdgeInsets.all(8.0),
                                children: [
                                  TextButton(
                                    child: const Text('??????'),
                                    onPressed: () => Navigator.pop(context, '??????'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, '??????');

                                      ocrTargetInsertUpate(thisyear.toString(), thismonth.toString().padLeft(2, "0").toString(), goal_Controller_total.text.toString(), goal_Controller_feed.text.toString(), goal_Controller_sevrer.text.toString(), goal_Controller_cross.text.toString());
                                      goal_Controller_cross.clear();
                                      goal_Controller_feed.clear();
                                      goal_Controller_sevrer.clear();
                                      goal_Controller_total.clear();
                                      Navigator.of(context).popUntil((route) => route.isFirst);
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => PregnantOwnerGraphPage()));
                                    },
                                    child: const Text('??????'),
                                  ),
                                ]
                            )


                          ]
                      );
                      // child: null,;
                      // )
                    }
                    );
                  }
              ),
            ]
        )
    );
  }

//????????????**********************
  LineChartData mainChart_sow_cross() {
    List<Color> gradientColors_values = [
      const Color(0xff23b6e6),
      const Color(0xff02d39a),
    ];

    List<Color> gradientColorsAvg = [
      const Color(0xfffa0000),
      const Color(0xffffdd00),
    ];

    final oneweekMate = mating_week1;
    final twoweekMate = mating_week2;
    final threeweekMate = mating_week3;
    final fourweekMate = mating_week4;
    final goalMate = mating_goal;


    return LineChartData(

      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 10,
        drawHorizontalLine: true,

        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Color(0xff000000),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Color(0xff000000),
            strokeWidth: 1,
          );
        },
      ),

      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
              color: Color(0xff000000),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            // print('bottomTitles $value');
            switch (value.toInt()) {
              case 0:
                return '1???';
              case 3:
                return '2???';
              case 6:
                return '3???';
              case 9:
                return '4???';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 10,
          textStyle: const TextStyle(
            color: Color(0xff000000),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
      // // borderData: FlBorderData(
      // //     show: true,
      // //     border: Border.all(color: const Color(0xff000000), width: 1)),
      minX: 0,
      maxX: 9,
      minY: 0,
      maxY: 40,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, oneweekMate.toDouble()),
            FlSpot(3, twoweekMate.toDouble()),
            FlSpot(6, threeweekMate.toDouble()),
            FlSpot(9, fourweekMate.toDouble()),
          ],

          isCurved: true,
          colors: gradientColors_values,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
        ),
        LineChartBarData(
          spots: [
            FlSpot(0, goalMate.toDouble()),
            FlSpot(3, goalMate.toDouble()),
            FlSpot(6, goalMate.toDouble()),
            FlSpot(9, goalMate.toDouble()),
          ],
          isCurved: true,
          colors: gradientColorsAvg,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
        ),
      ],
    );
  }

//????????????******************
  LineChartData mainChart_sow_sevrer() {
    List<Color> gradientColors_values = [
      const Color(0xff23b6e6),
      const Color(0xff02d39a),
    ];

    List<Color> gradientColors_avg = [
      const Color(0xfffa0000),
      const Color(0xffffdd00),
    ];

    final oneweek_feedbaby = feedbaby_week1;
    final twoweek_feedbaby = feedbaby_week2;
    final threeweek_feedbaby = feedbaby_week3;
    final fourweek_feedbaby = feedbaby_week4;
    final goal_feedbaby = feedbaby_goal;

    return LineChartData(

      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 10,
        drawHorizontalLine: true,

        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Color(0xff000000),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Color(0xff000000),
            strokeWidth: 1,
          );
        },
      ),

      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
              color: Color(0xff000000),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            // print('bottomTitles $value');
            switch (value.toInt()) {
              case 0:
                return '1???';
              case 3:
                return '2???';
              case 6:
                return '3???';
              case 9:
                return '4???';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 10,
          textStyle: const TextStyle(
            color: Color(0xff000000),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          // getTitles: (value) {
          //   // print('leftTitles $value');
          //   if (value.toInt() == minvalue_teen) {
          //     return minvalue_teen.toInt().toString();
          //   }else if(value.toInt() == maxvalue_teen){
          //     return maxvalue_teen.toInt().toString();
          //   }else if(value.toInt() == goal_teen){
          //     return goal_teen.toInt().toString();
          //   }else{
          //     return value.toInt().toString();
          //   }
          // },
        ),
      ),
      // // borderData: FlBorderData(
      // //     show: true,
      // //     border: Border.all(color: const Color(0xff000000), width: 1)),
      minX: 0,
      maxX: 9,
      minY: 0,
      maxY: 40,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, oneweek_feedbaby.toDouble()),
            FlSpot(3, twoweek_feedbaby.toDouble()),
            FlSpot(6, threeweek_feedbaby.toDouble()),
            FlSpot(9, fourweek_feedbaby.toDouble()),
          ],

          isCurved: true,
          colors: gradientColors_values,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
        ),
        LineChartBarData(
          spots: [
            FlSpot(0, goal_feedbaby.toDouble()),
            FlSpot(3, goal_feedbaby.toDouble()),
            FlSpot(6, goal_feedbaby.toDouble()),
            FlSpot(9, goal_feedbaby.toDouble()),
          ],
          isCurved: true,
          colors: gradientColors_avg,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
        ),
      ],
    );
  }

//????????????******************
  LineChartData mainChart_total_baby() {
    List<Color> gradientColors_values = [
      const Color(0xff23b6e6),
      const Color(0xff02d39a),
    ];

    List<Color> gradientColors_avg = [
      const Color(0xfffa0000),
      const Color(0xffffdd00),
    ];
    // array_graph = receiveresult_graph();
    print("main ????????? ????????? ??? ");
    // print(array_graph);
    //var oneweek  = array_graph[0] as double;
    final oneweek_mortality = mortality_week1;
    final twoweek_mortality = mortality_week2;
    final threeweek_mortality = mortality_week3;
    final fourweek_mortality = mortality_week4;
    final goal_die = mortality_goal;


    return LineChartData(

      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 10,
        drawHorizontalLine: true,

        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Color(0xff000000),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Color(0xff000000),
            strokeWidth: 1,
          );
        },
      ),

      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
              color: Color(0xff000000),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            // print('bottomTitles $value');
            switch (value.toInt()) {
              case 0:
                return '1???';
              case 3:
                return '2???';
              case 6:
                return '3???';
              case 9:
                return '4???';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 10,
          textStyle: const TextStyle(
            color: Color(0xff000000),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          // getTitles: (value) {
          //   // print('leftTitles $value');
          //   if (value.toInt() == minvalue_die) {
          //     return minvalue_die.toInt().toString();
          //   }else if(value.toInt() == maxvalue_die){
          //     return maxvalue_die.toInt().toString();
          //   }else if(value.toInt() == goal_die){
          //     return goal_die.toInt().toString();
          //   }else{
          //     return value.toInt().toString();
          //   }
          //   return '';
          // },

        ),
      ),
      // // borderData: FlBorderData(
      // //     show: true,
      // //     border: Border.all(color: const Color(0xff000000), width: 1)),
      minX: 0,
      maxX: 9,
      minY: 0,
      maxY: 40,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, oneweek_mortality.toDouble()),
            FlSpot(3, twoweek_mortality.toDouble()),
            FlSpot(6, threeweek_mortality.toDouble()),
            FlSpot(9, fourweek_mortality.toDouble()),
          ],

          isCurved: true,
          colors: gradientColors_values,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
        ),
        LineChartBarData(
          spots: [
            FlSpot(0, goal_die.toDouble()),
            FlSpot(3, goal_die.toDouble()),
            FlSpot(6, goal_die.toDouble()),
            FlSpot(9, goal_die.toDouble()),
          ],
          isCurved: true,
          colors: gradientColors_avg,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
        ),
      ],
    );
  }

//????????????******************
  LineChartData mainChart_feed_baby() {
    List<Color> gradientColors_values = [
      const Color(0xff23b6e6),
      const Color(0xff02d39a),
    ];

    List<Color> gradientColors_avg = [
      const Color(0xfffa0000),
      const Color(0xffffdd00),
    ];
    // array_graph = receiveresult_graph();
    print("main ????????? ????????? ??? ");

    // print(array_graph);
    //var oneweek  = array_graph[0] as double;
    final oneweek_shipment = shipment_week1;
    final twoweek_shipment = shipment_week2;
    final threeweek_shipment = shipment_week3;
    final fourweek_shipment = shipment_week4;
    final goal_shipment = shipment_goal;


    return LineChartData(

      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 10,
        drawHorizontalLine: true,

        //?????????
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Color(0xff000000),
            strokeWidth: 1,
          );
        },
        //?????????
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Color(0xff000000),
            strokeWidth: 1,
          );
        },
      ),

      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
              color: Color(0xff000000),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            // print('bottomTitles $value');
            switch (value.toInt()) {
              case 0:
                return '1???';
              case 3:
                return '2???';
              case 6:
                return '3???';
              case 9:
                return '4???';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 10,
          textStyle: const TextStyle(
            color: Color(0xff000000),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          // getTitles: (value) {
          //   // print('leftTitles $value');
          //   if (value.toInt() == minvalue_die) {
          //     return minvalue_die.toInt().toString();
          //   }else if(value.toInt() == maxvalue_die){
          //     return maxvalue_die.toInt().toString();
          //   }else if(value.toInt() == goal_die){
          //     return goal_die.toInt().toString();
          //   }else{
          //     return value.toInt().toString();
          //   }
          //   return '';
          // },
        ),
      ),
      // // borderData: FlBorderData(
      // //     show: true,
      // //     border: Border.all(color: const Color(0xff000000), width: 1)),
      minX: 0,
      maxX: 9,
      minY: 0,
      maxY: 40,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, oneweek_shipment.toDouble()),
            FlSpot(3, twoweek_shipment.toDouble()),
            FlSpot(6, threeweek_shipment.toDouble()),
            FlSpot(9, fourweek_shipment.toDouble()),
          ],

          isCurved: true,
          colors: gradientColors_values,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
        ),
        LineChartBarData(
          spots: [
            FlSpot(0, goal_shipment.toDouble()),
            FlSpot(3, goal_shipment.toDouble()),
            FlSpot(6, goal_shipment.toDouble()),
            FlSpot(9, goal_shipment.toDouble()),
          ],
          isCurved: true,
          colors: gradientColors_avg,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
        ),
      ],
    );
  }

  MaxValue(List list) {
    double firstval = 0;
    for (int i = 1; i < list.length; i++) {
      firstval = list[0];
      if (list[i] > firstval)
        firstval = list[i];
    }
    return firstval;
  }
}