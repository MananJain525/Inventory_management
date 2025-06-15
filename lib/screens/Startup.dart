import 'package:flutter/material.dart';

class StartUp extends StatelessWidget {
  const StartUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Entry')),
      body: Center(child: Text('Welcome to the Entry Point')),
    );
  }
}