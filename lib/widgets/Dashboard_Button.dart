import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardButton extends StatelessWidget{
  final String iconPath;
  final String label;
  final VoidCallback onPressed;

  const DashboardButton({
    Key? key,
    required this.iconPath,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.7,
      height: screenWidth * 0.15,
      margin: EdgeInsets.symmetric(vertical: screenWidth * 0.025),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF2E2E2E),
          foregroundColor: Colors.white,
          elevation: 3,
          shadowColor: Colors.black,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenWidth * 0.03,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return Color(0x33BBBBBB);
              }
              if (states.contains(WidgetState.hovered)) {
                return Color(0x11BBBBBB);
              }
              return null;
            },
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              iconPath,
              width: screenWidth * 0.075,
              height: screenWidth * 0.075,
            ),
            SizedBox(width: screenWidth * 0.04), // Space between icon and text
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: screenWidth * 0.0525, // Responsive font size
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  fontFamily: 'Inter',
                ),
                overflow: TextOverflow.ellipsis, // Handle long text
              ),
            ),
          ],
        ),
      ),
    );
  }
}