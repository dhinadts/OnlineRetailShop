import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utility {
  Future<void> toast(String msg, Color color) async {
    await Fluttertoast.showToast(
        msg: msg,
        backgroundColor: color,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP);
  }
}
