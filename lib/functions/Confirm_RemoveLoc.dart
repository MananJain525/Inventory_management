import 'package:flutter/material.dart';
import 'package:inventory_management_system/screens/Dashboard.dart';
import 'package:inventory_management_system/widgets/AppBar.dart';

class ConfirmRemoveScreen extends StatelessWidget {
  final String location;

  const ConfirmRemoveScreen({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    const designWidth = 440.0;
    const designHeight = 956.0;

    double scaleW(double px) => px / designWidth * screenWidth;
    double scaleH(double px) => px / designHeight * screenHeight;

    return Scaffold(
      appBar:  SimpleAppBar(
        title: 'REMOVE LOCATION',
        onBack: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Dashboard()),
          );
        },
        onProfile: () {},
      ),
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: scaleW(32),
          vertical: scaleH(80),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "CHOOSE LOCATION",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: scaleW(25),
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: scaleH(12)),
            Container(
              width: double.infinity,
              height: scaleH(53),
              padding: EdgeInsets.symmetric(horizontal: scaleW(12)),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(6),
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                location,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: scaleW(24),
                  color: Colors.white,
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: screenWidth * 0.4,
                  height: scaleH(48),
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Text(
                      'EDIT',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: scaleW(16),

                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.4,
                  height: scaleH(48),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Text(
                      'CONFIRM',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: scaleW(19),
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: scaleH(40)),
          ],
        ),
      ),
    );
  }
}