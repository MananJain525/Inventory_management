import 'package:flutter/material.dart';

class RemoveLoc extends StatelessWidget {
  const RemoveLoc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'REMOVE LOCATION',
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
