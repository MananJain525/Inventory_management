import 'package:flutter/material.dart';
import 'package:inventory_management_system/functions/Confirm_RemoveLoc.dart';
import 'package:inventory_management_system/screens/Dashboard_Admin.dart';
import 'package:inventory_management_system/widgets/AppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemoveLoc extends StatefulWidget {
  @override
  _RemoveLocState createState() => _RemoveLocState();
}

class _RemoveLocState extends State<RemoveLoc> {
  String? _selectedLocationId;
  List<Map<String, String>> _locations = [];

  @override
  void initState() {
    super.initState();
    fetchLocations();
  }

  Future<void> fetchLocations() async {
    final snapshot = await FirebaseFirestore.instance.collection('locations').get();

    setState(() {
      _locations = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'name': doc['name'].toString().trim(),
        };
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: SimpleAppBar(
        title: 'REMOVE LOCATION',
        onBack: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashboardAdmin()),
          );
        },
        onProfile: () {},
      ),
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.08),
            Text(
              "CHOOSE LOCATION",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: width * 0.05,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: height * 0.015),
            _locations.isEmpty
                ? Center(child: CircularProgressIndicator(color: Colors.white))
                : Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButton<String>(
                value: _selectedLocationId,
                isExpanded: true,
                dropdownColor: Colors.grey[850],
                hint: Text(
                  "Select",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: width * 0.05,
                    color: Colors.white70,
                  ),
                ),
                iconEnabledColor: Colors.white,
                underline: const SizedBox(),
                items: _locations.map((loc) {
                  return DropdownMenuItem<String>(
                    value: loc['id'],
                    child: Text(
                      loc['name'] ?? '',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: width * 0.045,
                        color: Colors.white,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedLocationId = val;
                  });
                },
              ),
            ),
            const Spacer(),
            Center(
              child: SizedBox(
                width: width * 0.4,
                height: height * 0.06,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: _selectedLocationId == null
                      ? null
                      : () async {
                    final selectedLoc = _locations.firstWhere(
                            (loc) => loc['id'] == _selectedLocationId);

                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ConfirmRemoveScreen(
                          locationId: selectedLoc['id']!,
                          locationName: selectedLoc['name']!,
                        ),
                      ),
                    );

                    if (result == true) {
                      setState(() {
                        _selectedLocationId = null;
                      });

                      await fetchLocations();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Center(
                            child: Text(
                              'REMOVED SUCCESSFULLY!',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          backgroundColor: Colors.black,
                          behavior: SnackBarBehavior.floating,
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          margin: EdgeInsets.only(
                            bottom:
                            MediaQuery.of(context).size.height * 0.08,
                            left: MediaQuery.of(context).size.width * 0.2,
                            right:
                            MediaQuery.of(context).size.width * 0.2,
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "REMOVE",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.06,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.04),
          ],
        ),
      ),
    );
  }
}
