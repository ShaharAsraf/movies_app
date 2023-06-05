import 'package:flutter/material.dart';
import 'package:movies_app/src/app.dart';
import 'package:movies_app/src/utils/prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsUtils.init();
  runApp(const MyApp());
}
