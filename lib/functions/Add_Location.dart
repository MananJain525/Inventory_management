import 'package:flutter/material.dart';
import 'package:inventory_management_system/widgets/AppBar.dart';

class AddLoc extends StatelessWidget {
const AddLoc({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: SimpleAppBar(
        title: 'ADD LOCATION',
        onBack: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Dashboard()),
          );
        },
        onProfile: () {},
      ),
body: Center(child: Text('yet to code')),
);
}
} 
