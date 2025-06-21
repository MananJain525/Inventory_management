import 'package:flutter/material.dart';
import 'package:inventory_management_system/screens/Dashboard.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: screenSize.width * 0.5,
                  height: screenSize.height * 0.25,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: screenSize.height * 0.05),
                ElevatedButton.icon(
                  onPressed: () {
                    // Add Firebase here later
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Dashboard()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  icon: Image.asset(
                    'assets/images/google.png',
                    height: screenSize.height * 0.03, // responsive height
                  ),
                  label: Text(
                    'Sign in with Google',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenSize.width * 0.045, // responsive font size
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
