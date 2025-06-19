import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_management_system/screens/Dashboard_Admin.dart';
import 'package:inventory_management_system/screens/Password_Screen.dart';
import 'package:inventory_management_system/screens/Startup.dart';


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
        initialRoute: "/",
        routes: {
          "/":(context)=>StartUp(),
          "/password_screen":(context)=>PasswordScreen(),
          "/dashboard_admin":(context)=>DashboardAdmin()
        },
        //home: StartUp()
    );
  }
}