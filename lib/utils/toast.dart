import 'package:flutter/material.dart';

class AppToast {
  static void showSuccess(BuildContext context, String message, {int durationInSeconds = 2}) {
    var snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
      duration: Duration(seconds: durationInSeconds),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showError(BuildContext context, String message, {int durationInSeconds = 2}) {
    var snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      duration: Duration(seconds: durationInSeconds),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
