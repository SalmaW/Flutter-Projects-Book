import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final VoidCallback onPressed;
  const ProductivityButton(
      {Key? key,
      required this.color,
      required this.text,
      required this.size,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: this.color,
      minWidth: this.size,
      onPressed: this.onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

typedef CallBackSetting = void Function(String, int);

class SettingsButton extends StatelessWidget {
  final Color color;
  final String text;
  final int value;
  final double? size;
  final String setting;
  final CallBackSetting callBack;
  const SettingsButton(
      {Key? key,
      required this.color,
      required this.text,
      required this.value,
      this.size,
      required this.setting,
      required this.callBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => this.callBack(this.setting, this.value),
      minWidth: this.size,
      color: this.color,
      child: Text(
        this.text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
