import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const myapp(),
    );
  }
}

class myapp extends StatefulWidget {
  const myapp({Key? key}) : super(key: key);

  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  final textconroler1 = TextEditingController();
  final textconroler2 = TextEditingController();
  double numrical = 0;
  String statuse = '';

  @override
  void dispose() {
    textconroler2.dispose();
    textconroler1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "BMI Calculator",
            style: TextStyle(fontSize: 20, color: Colors.deepPurpleAccent),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 250,
              height: 150,
              child: TextField(
                controller: textconroler1,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Hight in cm', border: UnderlineInputBorder()),
              ),
            ),
            SizedBox(
              width: 250,
              height: 150,
              child: TextField(
                controller: textconroler2,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Wight in Kg', border: UnderlineInputBorder()),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (textconroler2.text == '' || textconroler1.text == '') {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            {
                              return AlertDialog(
                                title: const Text("Error missing informtion"),
                              );
                            }
                          });
                    } else {
                      numrical = outputvalue(double.parse(textconroler2.text),
                          double.parse(textconroler1.text));

                      statuse = statuselogic(numrical);
                    }
                  });
                },
                child: Text("Submit"),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: SizedBox(
                child: Container(
                    child: SfLinearGauge(
                  maximum: 40,
                  minimum: 0,
                  ranges: [
                    LinearGaugeRange(
                      startValue: 0,
                      endValue: 18,
                      color: Colors.yellow,
                    ),
                    LinearGaugeRange(
                      startValue: 18.5,
                      endValue: 24.5,
                      color: Colors.green,
                    ),
                    LinearGaugeRange(
                      startValue: 25,
                      endValue: 29.9,
                      color: Colors.orangeAccent,
                    ),
                    LinearGaugeRange(
                        startValue: 30, endValue: 34, color: Colors.redAccent),
                    LinearGaugeRange(
                      startValue: 35,
                      endValue: 40,
                      color: Colors.red,
                    )
                  ],
                  markerPointers: [
                    LinearShapePointer(
                      value: numrical,
                      color: Colors.black,
                    )
                  ],
                  barPointers: [
                    LinearBarPointer(
                      value: numrical,
                      color: Colors.transparent,
                    ),
                  ],
                )),
              ),
            ),
            Center(
              child: Text(statuse,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.black)),
            )
          ],
        ));
  }
}

outputvalue(double w, double h) {
  double hightinmeter = h / 100;
  double x = (w / (hightinmeter * hightinmeter));

  print('iamin');
  print(x);
  return x;
}

statuselogic(double n) {
  if (n > 0 && n < 18) {
    return 'under wight';
  } else if (n > 18 && n < 24.5) {
    return 'normal wight';
  } else if (n > 24.5 && n < 29.9) {
    return 'over wight';
  } else if (n > 29.9 && n < 30) {
    return 'obesity class 1';
  } else if (n > 30 && n < 34.9) {
    return 'obesity class2 ';
  } else if (n > 34.9 && n <= 40) {
    return 'Extreme  obesity ';
  } else {
    return '';
  }
}
