import 'package:flutter/material.dart';

Future<void> showLoading(BuildContext context) async {
  AlertDialog alert = const AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Center(
      child: CircularProgressIndicator(),
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      //prevent back button press
      return WillPopScope(onWillPop: () async => false, child: alert);
    },
  );
}
