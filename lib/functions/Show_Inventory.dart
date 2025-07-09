import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_management_system/screens/Dashboard.dart';
import 'package:inventory_management_system/widgets/AppBar.dart';

class ShowInventory extends StatefulWidget {
  const ShowInventory({super.key});

  @override
  State<ShowInventory> createState() => _ShowInventoryState();
}

class _ShowInventoryState extends State<ShowInventory> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';
  Map<String, Map<String, int>> inventoryData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchInventory();
  }

  Future<void> fetchInventory() async {
    try {
      final locationsSnapshot =
      await FirebaseFirestore.instance.collection('locations').get();

      print('Found ${locationsSnapshot.docs.length} locations');

      final Map<String, Map<String, int>> tempData = {};

      for (final locDoc in locationsSnapshot.docs) {
        print('Checking location: ${locDoc.id}');
        final invSnapshot = await FirebaseFirestore.instance
            .collection('locations')
            .doc(locDoc.id)
            .collection('inventory')
            .get();

        print(' → ${invSnapshot.docs.length} items found');

        if (invSnapshot.docs.isNotEmpty) {
          tempData[locDoc.id] = {};
          for (final itemDoc in invSnapshot.docs) {
            final data = itemDoc.data();
            print('    • Item data: $data');

            final itemName = data['Item Name'];
            final quantity = data['Quantity'] ?? 0;

            if (itemName != null && quantity > 0) {
              tempData[locDoc.id]![itemName] = quantity;
            }
          }
        }
      }

      setState(() {
        inventoryData = tempData;
        isLoading = false;  // ✅ Ensure this always runs
      });

      print('Inventory loaded: $inventoryData');
    } catch (e) {
      print('Error loading inventory: $e');
      setState(() => isLoading = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final filteredData = inventoryData.entries.where((entry) {
      final locationName = entry.key.toLowerCase();
      final matchesLocation =
      locationName.contains(searchQuery.toLowerCase());

      final matchesItem = entry.value.keys.any(
              (item) => item.toLowerCase().contains(searchQuery.toLowerCase()));

      return matchesLocation || matchesItem;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: SimpleAppBar(
        title: 'SHOW INVENTORY',
        onBack: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Dashboard()),
          );
        },
        onProfile: () {},
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding:
        EdgeInsets.only(top: screenWidth * 0.1),
        child: Column(
          children: [
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: TextField(
                style: TextStyle(
                  fontSize: screenWidth * 0.05
                ),
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF2E2E2E),
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        searchQuery = "";
                      });
                    },
                  )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
            SizedBox(height: screenWidth * 0.1),
            Expanded(
              child: filteredData.isEmpty
                  ? const Center(
                child: Text(
                  "No inventory matches your search.",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              )
                  : ListView(
                children: filteredData.map((entry) {
                  return Card(
                    color: const Color(0xFF2E2E2E),
                    margin: EdgeInsets.symmetric(
                        vertical: screenWidth * 0.025,
                        horizontal: screenWidth * 0.05),
                    child: ExpansionTile(
                      title: Text(
                        entry.key,
                        style: TextStyle(
                            fontSize: screenWidth * 0.0625),
                      ),
                      children: entry.value.entries.map((itemEntry) {
                        return ListTile(
                          title: Text(
                            itemEntry.key,
                            style: TextStyle(
                                fontSize: screenWidth * 0.05),
                          ),
                          trailing: Text(
                            itemEntry.value.toString(),
                            style: TextStyle(
                                fontSize: screenWidth * 0.05),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
