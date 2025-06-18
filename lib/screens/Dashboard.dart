import 'package:flutter/material.dart';
import 'package:inventory_management_system/widgets/Dashboard_Button.dart';


class Dashboard extends StatelessWidget{
  const Dashboard({super.key});

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      appBar: AppBar(),
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
                  'Welcome  User!',
                  style: TextStyle(
                    fontFamily: 'Caveat'
                  ),
                ),
              ),
            ),
            SizedBox(height: screenWidth * 0.175),
            DashboardButton(
                iconPath: 'assets/icons/show_inventory.svg',
                label: "SHOW INVENTORY" ,
                onPressed: (){}
            ), //Show Inventory
            DashboardButton(
                iconPath: 'assets/icons/transfer_items.svg',
                label: "TRANSFER ITEMS" ,
                onPressed: (){}
            ), //Transfer Items
            DashboardButton(
                iconPath: 'assets/icons/add_location.svg',
                label: "ADD LOCATION" ,
                onPressed: (){}
            ), //Add Location
            DashboardButton(
                iconPath: 'assets/icons/history.svg',
                label: "HISTORY" ,
                onPressed: (){}
            ), //History
            DashboardButton(
                iconPath: 'assets/icons/admin_options.svg',
                label: "ADMIN OPTIONS" ,
                onPressed: (){
                  Navigator.pushNamed(
                    context,
                    '/password_screen',
                  );
                }
            ), //Admin Options
          ],
        ),
      ),
    );
  }
}