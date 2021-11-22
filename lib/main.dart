import 'package:flutter/material.dart';

import 'app.dart';
import 'core/di/injector.dart';

void main() async {
  setupInjection();
  runApp(const App());
}
