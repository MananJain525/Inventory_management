import 'package:flutter/material.dart';
import 'package:inventory_management_system/widgets/Dashboard_Button.dart';
import 'package:inventory_management_system/functions/Show_Inventory.dart';
import 'package:inventory_management_system/functions/Transfer_Inventory.dart';
import 'package:inventory_management_system/functions/Add_Location.dart';
import 'package:inventory_management_system/screens/Password_Screen.dart';
import 'package:inventory_management_system/screens/Startup.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF181818),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.logout, color: Colors.white),
          onPressed: () {
            // Navigate to StartUp and clear the stack
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const StartUp()),
              (route) => false,
            );
          },
        ),
        title: const Text(
          'Home Screen',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              // Placeholder for future profile action
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: screenWidth * 0.175),
            SizedBox(
              height: screenWidth * 0.2,
              width: screenWidth * 0.8,
              child: const FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  'Welcome  User!',
                  style: TextStyle(
                    fontFamily: 'Caveat',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenWidth * 0.175),
            DashboardButton(
              iconPath: 'assets/icons/show_inventory.svg',
              label: "SHOW INVENTORY",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ShowInventory()),
                );
              },
            ),
            DashboardButton(
              iconPath: 'assets/icons/transfer_items.svg',
              label: "TRANSFER ITEMS",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TransferInventory()),
                );
              },
            ),
            DashboardButton(
              iconPath: 'assets/icons/add_location.svg',
              label: "ADD LOCATION",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddLoc()),
                );
              },
            ),
            DashboardButton(
              iconPath: 'assets/icons/history.svg',
              label: "HISTORY",
              onPressed: () {},
            ),
            DashboardButton(
              iconPath: 'assets/icons/admin_options.svg',
              label: "ADMIN OPTIONS",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PasswordScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
