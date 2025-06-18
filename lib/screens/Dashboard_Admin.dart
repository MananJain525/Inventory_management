import 'package:flutter/material.dart';

class DashboardAdmin extends StatelessWidget {
  const DashboardAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double buttonWidth = screenWidth * 0.8;
    if (buttonWidth > 400) buttonWidth = 400;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("ADMIN OPTIONS"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.account_circle_outlined),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildResponsiveButton(
                icon: Icons.add_to_photos,
                label: 'ADD ITEMS',
                width: buttonWidth,
              ),
              const SizedBox(height: 20),
              _buildResponsiveButton(
                icon: Icons.location_on_outlined,
                label: 'REMOVE LOCATION',
                width: buttonWidth,
              ),
              const SizedBox(height: 20),
              _buildResponsiveButton(
                icon: Icons.delete_outline,
                label: 'REMOVE ITEMS',
                width: buttonWidth,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResponsiveButton({
    required IconData icon,
    required String label,
    required double width,
  }) {
    return SizedBox(
      width: width,
      height: 60, // ⬅️ Increased height to match your new design
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2C2C2C),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          // TODO: Add logic here
        },
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24), // ⬅️ Slightly larger icon
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17, // ⬅️ Slightly larger font
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }}

