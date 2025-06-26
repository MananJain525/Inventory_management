import 'package:flutter/material.dart';
import 'package:inventory_management_system/widgets/AppBar.dart';

import '../screens/Dashboard.dart';

class TransferInventory extends StatelessWidget {
  const TransferInventory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'TRANSFER INVENTORY',
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
