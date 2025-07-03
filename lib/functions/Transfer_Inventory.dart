import 'package:flutter/material.dart';
import 'package:inventory_management_system/functions/Item_Selector.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransferInventory extends StatefulWidget {
  const TransferInventory({super.key});

  @override
  State<TransferInventory> createState() => _TransferInventoryState();
}


class _TransferInventoryState extends State<TransferInventory> {
  String fromLocation = 'Select';
  String toLocation = 'Select';
  TextEditingController searchController = TextEditingController();
  List<String> locationNames = [];

  bool isTransferMode = true;

  @override
  void initState() {
    super.initState();
    fetchLocations();
  }


  Future<void> fetchLocations() async {
    final snapshot = await FirebaseFirestore.instance.collection('locations').get();

    setState(() {
      locationNames = snapshot.docs
          .map((doc) => doc['name'].toString())
          .toList();
    });
  }


  @override

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF1E1E1E),
        appBar: AppBar(
          backgroundColor: Color(0xFF181818),
          centerTitle: true,
          title: Text('Transfer Items'),
          titleTextStyle: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 24.0
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.account_circle_outlined, color: Colors.white),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              Container(
                margin: EdgeInsets.fromLTRB(30.0, 0.0, 36.0, 0.0),
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: Color(0xFF2E2E2E),
                  borderRadius: BorderRadius.circular(8.0),

                ),
                child: TextField(
                  controller: searchController,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: Colors.grey, size: 24.0,),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 24.0),
                    border: InputBorder.none,
          
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30.0, 0.0, 36.0, 0.0),
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: Color(0xFF2E2E2E),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              //SizedBox(height: 307.0),
              ItemSelectorWidget(),
          
          
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'From Locations',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                margin: EdgeInsets.fromLTRB(30.0, 0.0, 36.0, 0.0),
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                    color: Color(0xFF2E2E2E),
                    borderRadius: BorderRadius.circular(8.0),

                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    dropdownColor: Color(0xFF2A2A2A),
                    value: fromLocation,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                    items: [
                      DropdownMenuItem(
                        value: 'Select',
                        child: Text('Select', style: TextStyle(color: Colors.white70)),
                      ),
                      ...locationNames.map((loc) { //
                        return DropdownMenuItem(
                          value: loc,
                          child: Text(loc, style: TextStyle(color: Colors.white)),
                        );
                      }).toList(),
                    ],
          
                    onChanged: isTransferMode
                        ? (value) {
                      setState(() {
                        fromLocation = value!;
                      });
                    }
                        : null,
                  ),
                ),
              ),
              SizedBox(height: 29.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'To Locations',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                margin: EdgeInsets.fromLTRB(30.0, 0.0, 36.0, 0.0),
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                    color: Color(0xFF2E2E2E),
                    borderRadius: BorderRadius.circular(8.0),

                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    dropdownColor: Color(0xFF2A2A2A),
                    value: toLocation,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                    items: [
                      DropdownMenuItem(
                        value: 'Select',
                        child: Text('Select', style: TextStyle(color: Colors.white70)),
                      ),
                      ...locationNames.map((loc) { //
                        return DropdownMenuItem(
                          value: loc,
                          child: Text(loc, style: TextStyle(color: Colors.white)),
                        );
                      }).toList(),
                    ],
          
                    onChanged: isTransferMode
                        ? (value) {
                      setState(() {
                        toLocation = value!;
                      });
                    }
                        : null,
                  ),
                ),
              ),
              SizedBox(height: 80.0),
              isTransferMode ?
              GestureDetector(
                onTap: () {
                  if (toLocation == 'Select' || fromLocation == 'Select') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Please fill the details',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        backgroundColor: Colors.white,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(16),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                  else if(toLocation == fromLocation)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Both Locations can't be same",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        backgroundColor: Colors.white,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(16),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                  else {
                    setState(() {
                      isTransferMode = false;
                    });
                  }
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(30.0, 0.0, 36.0, 0.0),
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    'TRANSFER',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Edit Button (Outlined)
                  OutlinedButton(
                    onPressed: () {
                      // Change state if validation passes
                      setState(() {
                        isTransferMode = true;
                      }
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white, width: 1.5),
                      minimumSize: Size(80, 50), // Square-like with fixed size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // Rounded corners radius 5
                      ),
                    ),
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          
                  // Confirm Button (Filled)
                  ElevatedButton(
                    onPressed: () {
                      if (toLocation == 'Select' || fromLocation == 'Select') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please fill the details',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            backgroundColor: Colors.white,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.all(16),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Item Transferred Successfully',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: Colors.white,
                            behavior: SnackBarBehavior.floating, // Makes it hover
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Rounded corners
                            ),
                            margin: EdgeInsets.all(16), // Distance from screen edges
                            duration: Duration(seconds: 2), // Display time
                          ),
                        );
                        setState(() {
                          fromLocation = 'Select';
                          toLocation = 'Select';
                          searchController.clear();
                          isTransferMode = true; // Go back to transfer button
          
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: Size(80, 50), // Square-like with fixed size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // Rounded corners radius 5
                      ),
                    ),
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
          
            ],
          ),
        )
    );
  }
}


