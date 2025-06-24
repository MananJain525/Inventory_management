import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_management_system/functions/Show_Inventory.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((onValue) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const ShowInventory(),
        //home: StartUp()
    );
  }
}