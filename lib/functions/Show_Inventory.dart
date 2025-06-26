import 'package:flutter/material.dart';
import 'package:inventory_management_system/widgets/AppBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF1E1E1E)
      ),
      home: const ShowInventory(),
    );
  }
}

class ShowInventory extends StatefulWidget {
  const ShowInventory({super.key});

  @override
  State<ShowInventory> createState() => _ShowInventoryState();
}

class _ShowInventoryState extends State<ShowInventory> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  final Map<String, Map<String, int>> inventoryData = {
    "AUDITORIUM": {
      "XLR Cables": 3,
      "5 - 5 Cables": 4,
      "Stereo → 3.5": 2,
      "Yamaha D8R": 1,
      "Yamaha D2R": 2,
      "Power Cables": 3,
    },
    "AH1 104": {
      "XLR Cables": 2,
      "5 - 5 Cables": 1,
      "Stereo → 3.5": 1,
      "Yamaha D8R": 0,
      "Yamaha D2R": 1,
      "Power Cables": 2,
    },
    "CC LAB": {
      "XLR Cables": 5,
      "5 - 5 Cables": 3,
      "Stereo → 3.5": 2,
      "Yamaha D8R": 1,
      "Yamaha D2R": 1,
      "Power Cables": 1,
    },
    "SAC": {
      "XLR Cables": 1,
      "5 - 5 Cables": 2,
      "Stereo → 3.5": 1,
      "Yamaha D8R": 1,
      "Yamaha D2R": 1,
      "Power Cables": 1,
    },
    "FOOD KING": {
      "XLR Cables": 2,
      "5 - 5 Cables": 2,
      "Stereo → 3.5": 2,
      "Yamaha D8R": 0,
      "Yamaha D2R": 1,
      "Power Cables": 2,
    },
  };

  @override
  Widget build(BuildContext context) {
    final filteredData = inventoryData.entries.where((entry) {
      final locationName = entry.key.toLowerCase();
      final matchesLocation = locationName.contains(searchQuery.toLowerCase());

      final matchesItem = entry.value.keys.any((item) =>
          item.toLowerCase().contains(searchQuery.toLowerCase()));

      return matchesLocation || matchesItem;
    }).toList();

    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.only(top: 20), // Space below AppBar
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF2E2E2E),
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
            const SizedBox(height: 20), // Spacing between search bar and list
            Expanded(
              child: ListView(
                children: filteredData.map((entry) {
                  return Card(
                    color: Color(0xFF2E2E2E),
                    margin: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 12),
                    child: ExpansionTile(
                      title: Text(entry.key),
                      children: entry.value.entries.map((itemEntry) {
                        return ListTile(
                          title: Text(itemEntry.key),
                          trailing: Text(itemEntry.value.toString()),
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

class InventorySection extends StatefulWidget {
  final String title;
  final Map<String, int> items;

  const InventorySection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  State<InventorySection> createState() => _InventorySectionState();
}

class _InventorySectionState extends State<InventorySection> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        trailing: Icon(
          isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          color: Colors.white,
        ),
        onExpansionChanged: (val) {
          setState(() {
            isExpanded = val;
          });
        },
        children: widget.items.entries.map((entry) {
          return ListTile(
            title: Text(
              entry.key,
              style: const TextStyle(color: Colors.white),
            ),
            trailing: Text(
              entry.value.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
