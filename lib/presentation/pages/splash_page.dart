import 'dart:async';

import 'package:container_locations/core/router.dart';
import 'package:container_locations/core/util/connection_helper.dart';
import 'package:container_locations/core/util/storage_helper.dart';
import 'package:container_locations/core/values/strings.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: _scaffoldKey,
        body: const Center(child: Text(StringResources.splashPage)));
  }

  startTimer() {
    var _duration = const Duration(milliseconds: 500);
    return Timer(_duration, checkConnection);
  }

  checkConnection() {
    ConnectionHelper.hasConnection().then((value) => value
        ? checkLoggedIn()
        : showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => WillPopScope(
                  onWillPop: () async => false,
                  child: const AlertDialog(
                    title: Text('Warning'),
                    content: Text('Please check your network connection.'),
                  ),
                )));
  }

  checkLoggedIn() {
    _isLoggedIn().then((value) {
      if (value) {
        NavigatorExt(context).navigateToOperationPage();
      } else {
        NavigatorExt(context).navigateToLoginPage();
      }
    });
  }

  Future<bool> _isLoggedIn() async {
    bool? isLoggedIn = await StorageHelper.getBool(StorageKeys.loggedIn);
    return isLoggedIn ?? false;
  }
}
