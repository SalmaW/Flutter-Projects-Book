import 'dart:ffi';
import 'package:chap3_my_time/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Settings(),
    );
  }
}

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late TextEditingController txtWork;
  late TextEditingController txtShort;
  late TextEditingController txtLong;
  static const String WorkTime = 'workTime';
  static const String ShortBreak = 'shortBreak';
  static const String LongBreak = 'longBreak';
  late int workTime;
  late int shortBreak;
  late int longBreak;
  late SharedPreferences prefs;

  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle testStyle = TextStyle(fontSize: 24);

    return Container(
      child: GridView.count(
        crossAxisCount: 3,
        scrollDirection: Axis.vertical,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: const EdgeInsets.all(20),
        children: [
          Text('Work', style: testStyle),
          Text(''),
          Text(''),
          SettingsButton(
            color: Color(0xff455A64),
            text: '-',
            value: -1,
            setting: WorkTime,
            callBack: updateSetting,
          ),
          TextField(
            style: testStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtWork,
          ),
          SettingsButton(
            color: Color(0xff009688),
            text: '+',
            value: 1,
            setting: WorkTime,
            callBack: updateSetting,
          ),
          Text('Short', style: testStyle),
          Text(''),
          Text(''),
          SettingsButton(
            color: Color(0xff455A64),
            text: '-',
            value: -1,
            setting: ShortBreak,
            callBack: updateSetting,
          ),
          TextField(
            style: testStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtShort,
          ),
          SettingsButton(
            color: Color(0xff009688),
            text: '+',
            value: 1,
            setting: ShortBreak,
            callBack: updateSetting,
          ),
          Text('Long', style: testStyle),
          Text(''),
          Text(''),
          SettingsButton(
            color: Color(0xff455A64),
            text: '-',
            value: -1,
            setting: LongBreak,
            callBack: updateSetting,
          ),
          TextField(
            style: testStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtLong,
          ),
          SettingsButton(
            color: Color(0xff009688),
            text: '+',
            value: 1,
            setting: LongBreak,
            callBack: updateSetting,
          ),
        ],
      ),
    );
  }

  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    int? workTime = prefs.getInt(WorkTime);
    if (workTime == null) {
      await prefs.setInt(WorkTime, int.parse('30'));
    }
    int? shortBreak = prefs.getInt(ShortBreak);
    if (shortBreak == null) {
      await prefs.setInt(ShortBreak, int.parse('5'));
    }
    int? longBreak = prefs.getInt(LongBreak);
    if (longBreak == null) {
      await prefs.setInt(LongBreak, int.parse('20'));
    }
    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }

  updateSetting(String key, int value) {
    switch (key) {
      case WorkTime:
        {
          int workTime = prefs.getInt(WorkTime)!;
          workTime += value;
          if (workTime >= 1 && workTime <= 180) {
            prefs.setInt(WorkTime, workTime);
            setState(() {
              txtWork.text = workTime.toString();
            });
          }
        }
        break;
      case ShortBreak:
        {
          int short = prefs.getInt(ShortBreak)!;
          short += value;
          if (short >= 1 && short <= 120) {
            prefs.setInt(ShortBreak, short);
            setState(() {
              txtShort.text = short.toString();
            });
          }
        }
        break;
      case LongBreak:
        {
          int long = prefs.getInt(LongBreak)!;
          long += value;
          if (long >= 1 && long <= 180) {
            prefs.setInt(LongBreak, long);
            setState(() {
              txtLong.text = long.toString();
            });
          }
        }
        break;
    }
  }
}
