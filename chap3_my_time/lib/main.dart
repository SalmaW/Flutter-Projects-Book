import 'package:chap3_my_time/timermodel.dart';
import 'package:chap3_my_time/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './timer.dart';
import './settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Work Timer',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: TimerHomePage(),
    );
  }
}

class TimerHomePage extends StatelessWidget {
  final double defaultPadding = 5.0;
  final CountDownTimer timer = CountDownTimer();

  TimerHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    timer.startWork();

    final List<PopupMenuItem<String>> menuItems =
        List<PopupMenuItem<String>>.from(<PopupMenuItem<String>>[]);
    menuItems.add(PopupMenuItem(
      value: 'Settings',
      child: Text('Settings'),
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text('My Work Timer'),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return menuItems.toList();
            },
            onSelected: (s) {
              if (s == 'Settings') {
                goToSettings(context);
              }
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext, BoxConstraints constraints) {
          final double availableWidth = constraints.maxWidth;
          return Column(
            children: [
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                      child: ProductivityButton(
                    color: Color(0xff009688),
                    text: 'Work',
                    onPressed: () => timer.startWork(),
                    size: 20,
                  )),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                      child: ProductivityButton(
                    color: Color(0xff607D8B),
                    text: 'Short Break',
                    onPressed: () => timer.startBreak(true),
                    size: 20,
                  )),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                      child: ProductivityButton(
                    color: Color(0xff455A64),
                    text: 'Long Break',
                    onPressed: () => timer.startBreak(false),
                    size: 20,
                  )),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                ],
              ),
              StreamBuilder(
                  initialData: '00:00',
                  stream: timer.stream(),
                  builder: (BuildContext, AsyncSnapshot snapshot) {
                    TimerModel timer = (snapshot.data == '00:00')
                        ? TimerModel('00:00', 1)
                        : snapshot.data;
                    return Expanded(
                      child: CircularPercentIndicator(
                        radius: availableWidth / 3,
                        lineWidth: 8,
                        percent: timer.percent,
                        progressColor: Color(0xff009688),
                        center: Text(
                          timer.time,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    );
                  }),
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                      child: ProductivityButton(
                    color: Color(0xff212121),
                    text: 'Stop',
                    onPressed: () => timer.stopTimer(),
                    size: 20,
                  )),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                      child: ProductivityButton(
                    color: Color(0xff009688),
                    text: 'Restart',
                    onPressed: () => timer.startTimer(),
                    size: 20,
                  )),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

void emptyMethod() {}

void goToSettings(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => SettingsScreen()));
}
