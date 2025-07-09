import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inventory_management_system/widgets/Dashboard_Button.dart';
import 'package:inventory_management_system/functions/Show_Inventory.dart';
import 'package:inventory_management_system/functions/Transfer_Inventory.dart';
import 'package:inventory_management_system/functions/Add_Location.dart';
import 'package:inventory_management_system/screens/Password_Screen.dart';
import 'package:inventory_management_system/screens/Startup.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String userName = 'User'; // Default fallback

  @override
  void initState() {
    super.initState();
    _getUserName();
  }

  void _getUserName() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        // Try to get the first name from display name
        String? displayName = user.displayName;
        if (displayName != null && displayName.isNotEmpty) {
          // Extract first name (everything before the first space)
          userName = displayName.split(' ').first;
        } else {
          // Fallback to email if no display name
          userName = 'User';
        }
      });
    }
  }

  Widget _buildProfileWidget(User? user) {
    if (user?.photoURL != null) {
      return CircleAvatar(
        radius: 16,
        backgroundImage: NetworkImage(user!.photoURL!),
        backgroundColor: Colors.grey[300],
      );
    } else {
      // Fallback to default icon if no profile image
      return const Icon(Icons.person, color: Colors.white);
    }
  }

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
          onPressed: () async {
            // Sign out from both Google and Firebase
            await GoogleSignIn().signOut();
            await FirebaseAuth.instance.signOut();
            // Navigate to StartUp and clear the stack
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const StartUp()),
                  (route) => false,
            );
          },
        ),
        title: const Text(
          'HOME SCREEN',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              return IconButton(
                icon: _buildProfileWidget(snapshot.data),
                onPressed: () {
                  // Placeholder for future profile action
                },
              );
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
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  'Welcome $userName!',
                  style: const TextStyle(
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