import 'package:container_locations/core/values/colors.dart' as colors;
import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
    textTheme: const TextTheme(
  headline1: TextStyle(
      color: colors.darkBlue,
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w900),
  headline3: TextStyle(
      color: colors.darkBlue,
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w900,
      fontSize: 20),
  headline4: TextStyle(
      color: colors.darkBlue,
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w800,
      fontSize: 16),
  bodyText1: TextStyle(
      color: colors.darkGrey,
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w700,
      fontSize: 16),
  button: TextStyle(
      color: colors.lightColor,
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w800,
      fontSize: 20),
));
