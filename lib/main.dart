import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_management_system/screens/Startup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();

await Firebase.initializeApp();

await SystemChrome.setPreferredOrientations([
DeviceOrientation.portraitUp,
]);

runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const StartUp(),
    );
  }
}