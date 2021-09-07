import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(const MyApp());

}
@immutable
class MyApp extends StatelessWidget {
  static const backgroundColor = Color.fromARGB(255, 31, 31, 31);

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logic&math puzzles',
      theme: ThemeData(scaffoldBackgroundColor: backgroundColor),
      home: const Home(),
    );
  }
}
