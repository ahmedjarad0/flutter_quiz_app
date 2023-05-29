import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension Helper on BuildContext {
  void showSnackBar({required String message, bool error = false}) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: error ? Colors.red : Colors.green,
      duration: Duration(seconds: 3),
    ));
  }
}
