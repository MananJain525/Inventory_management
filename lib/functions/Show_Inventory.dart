import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
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
      appBar: AppBar(
        title: const Text("Show Inventory"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.grey[850],
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.white),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      searchQuery = '';
                    });
                  },
                )
                    : null,
              ),
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: filteredData.map((entry) {
                return InventorySection(
                  title: entry.key,
                  items: entry.value,
                );
              }).toList(),
            ),
          ),
        ],
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