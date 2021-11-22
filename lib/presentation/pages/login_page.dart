import 'package:container_locations/core/router.dart';
import 'package:container_locations/core/util/storage_helper.dart';
import 'package:container_locations/core/values/strings.dart';
import 'package:container_locations/presentation/uicomponents/button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: _scaffoldKey,
        body: Center(
            child: ButtonWidget(
          customButton: CustomButton(
              label: StringResources.login,
              onPress: () {
                StorageHelper.setBool(StorageKeys.loggedIn, true);
                NavigatorExt(context).navigateToOperationPage();
              }),
        )));
  }
}
