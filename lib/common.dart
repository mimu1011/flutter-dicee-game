import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String _message;
  final Color color;
  final double fontSize;

  const CustomText(this._message,
      {this.color: Colors.white, this.fontSize: 20.0});

  @override
  Widget build(BuildContext context) {
    return Text(
      this._message,
      style: TextStyle(color: this.color, fontSize: this.fontSize),
    );
  }
}
