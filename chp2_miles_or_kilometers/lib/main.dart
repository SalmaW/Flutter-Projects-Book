import 'package:flutter/material.dart';
import 'convertion/convertion_loginc.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Measures Converter',
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _numberFrom = 0;
  late String? _startMeasure;
  late String? _convertedMeasure;
  double _result = 0;
  String? _resultMsg = "";

  final List<String> measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds (lbs)',
    'ounces',
  ];

  @override
  void initState() {
    _numberFrom = 0;
    _startMeasure = measures[0];
    _convertedMeasure = measures[5];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sizeX = MediaQuery.of(context).size.width;
    double sizeY = MediaQuery.of(context).size.height;
    //used of TextFields - DropDownButtons - Buttons
    final TextStyle inputStyle = TextStyle(
      fontSize: 20,
      color: Colors.green,
    );
    //used of Text
    final TextStyle labelStyle = TextStyle(
      fontSize: 28,
      color: Colors.brown[500],
    );

    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        title: Text('Measures Converter'),
      ),
      body: Container(
        width: sizeX,
        padding: EdgeInsets.all(sizeX / 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Value', style: labelStyle),
              SizedBox(height: sizeY / 25),
              TextField(
                keyboardType: TextInputType.number,
                style: inputStyle,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown)),
                  hintText: 'Please insert the measure to be converted',
                  suffixStyle: labelStyle,
                ),
                onChanged: (text) {
                  setState(() {
                    _numberFrom = double.parse(text);
                  });
                },
              ),
              SizedBox(height: sizeY / 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text('From', style: labelStyle),
                      DropdownButton<String>(
                        style: inputStyle,
                        value: _startMeasure,
                        items: measures.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: inputStyle),
                          );
                        }).toList(),
                        onChanged: (value) {
                          onStartMeasureChanged(value);
                        },
                      ),
                    ],
                  ),
                  SizedBox(width: sizeX / 15),
                  Column(
                    children: [
                      Text('To', style: labelStyle),
                      DropdownButton<String>(
                        style: inputStyle,
                        value: _convertedMeasure,
                        items: measures.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          onConvertedMeasureChanged(value);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: sizeY / 8),
              Text(
                _resultMsg.toString(),
                style: labelStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: sizeY / 15),
              FloatingActionButton.extended(
                isExtended: true,
                backgroundColor: Colors.green[300],
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                label: Text('Convert', style: labelStyle),
                onPressed: () => convert(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onStartMeasureChanged(String? value) {
    setState(() {
      _startMeasure = value;
    });
  }

  void onConvertedMeasureChanged(String? value) {
    setState(() {
      _convertedMeasure = value;
    });
  }

  void convert() {
    if (_startMeasure.toString().isEmpty ||
        _convertedMeasure.toString().isEmpty ||
        _numberFrom == 0) {
      return;
    }
    Conversion c = Conversion();
    double result = c.convert(
        _numberFrom, _startMeasure.toString(), _convertedMeasure.toString());
    setState(() {
      _result = result;
      if (result == 0) {
        _resultMsg = 'This conversion cannot be performed';
      } else {
        _resultMsg =
            '${_numberFrom.toString()} $_startMeasure are ${_result.toString()} $_convertedMeasure';
      }
    });
  }
}
