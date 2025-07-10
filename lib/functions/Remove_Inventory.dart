import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_management_system/widgets/AppBar.dart';

class RemoveInventoryPage extends StatefulWidget {
  const RemoveInventoryPage({super.key});

  @override
  State<RemoveInventoryPage> createState() => _RemoveInventoryPageState();
}

class _RemoveInventoryPageState extends State<RemoveInventoryPage> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _selectedItems = [];
  bool _removed = false;

  late double screenWidth, screenHeight;
  static const designWidth = 440.0;
  static const designHeight = 956.0;

  double scaleW(double px) => px / designWidth * screenWidth;
  double scaleH(double px) => px / designHeight * screenHeight;

  @override
  void initState() {
    super.initState();
    _loadInventory();
  }

  Future<void> _loadInventory() async {
    try {
      final invSnapshot = await FirebaseFirestore.instance
          .collection('locations')
          .doc('Auditorium')
          .collection('inventory')
          .get();

      setState(() {
        _selectedItems = invSnapshot.docs.map((doc) {
          final data = doc.data();
          return {
            'docId': doc.id,
            'name': data['Item Name'] ?? 'Unnamed',
            'qty': data['Quantity'] ?? 0,
            'removeQty': 0,
          };
        }).toList();
      });
    } catch (e) {
      print('Error loading inventory: $e');
    }
  }

  void _incrementQty(int index) {
    setState(() {
      if (_selectedItems[index]['removeQty'] < _selectedItems[index]['qty']) {
        _selectedItems[index]['removeQty']++;
      }
    });
  }

  void _decrementQty(int index) {
    setState(() {
      if (_selectedItems[index]['removeQty'] > 0) {
        _selectedItems[index]['removeQty']--;
      }
    });
  }

  void _confirmRemoval() async {
    for (final item in _selectedItems) {
      final int available = item['qty'];
      final int toRemove = item['removeQty'];

      if (toRemove > available) {
        _showErrorDialog("Cannot remove more than available for ${item['name']}");
        return;
      }

      if (toRemove > 0) {
        final ref = FirebaseFirestore.instance
            .collection('locations')
            .doc('Auditorium')
            .collection('inventory')
            .doc(item['docId']);

        final int updatedQty = available - toRemove;

        if (updatedQty == 0) {
          bool confirmDelete = await _showConfirmationDialog(
              "All quantity for '${item['name']}' will be removed. Delete item completely?");
          if (confirmDelete) {
            await ref.delete();
          } else {
            await ref.update({'Quantity': 0});
          }
        } else {
          await ref.update({'Quantity': updatedQty});
        }
      }
    }

    setState(() {
      _removed = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RemoveInventoryPage()),
      );
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text('Error', style: TextStyle(color: Colors.red)),
        content: Text(message, style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: SimpleAppBar(
        title: 'REMOVE INVENTORY',
        onBack: () => Navigator.pop(context),
        onProfile: () {},
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: scaleW(32), vertical: scaleH(20)),
        child: Column(
          children: [
            _buildSearchBox(),
            SizedBox(height: scaleH(20)),
            _selectedItems.isEmpty
                ? const Expanded(
              child: Center(
                child: Text(
                  "No inventory available.",
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ),
              ),
            )
                : Expanded(child: _buildItemList()),
            if (_removed)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.black,
                  child: const Text(
                    'REMOVED SUCCESSFULLY!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            SizedBox(height: scaleH(10)),
            if (!_removed)
              _buildButton(label: 'CONFIRM', filled: true, onPressed: _confirmRemoval),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return SizedBox(
      height: 53,
      child: TextField(
        controller: _searchController,
        style: const TextStyle(fontFamily: 'Roboto', fontSize: 20, color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFF2E2E2E),
          hintText: 'Search item name...',
          hintStyle: const TextStyle(color: Colors.white60),
          prefixIcon: const Icon(Icons.search, color: Colors.white60),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        ),
      ),
    );
  }

  Widget _buildItemList() {
    return ListView.builder(
      itemCount: _selectedItems.length,
      itemBuilder: (context, index) {
        final item = _selectedItems[index];
        return Container(
          margin: EdgeInsets.only(bottom: scaleH(12)),
          decoration: BoxDecoration(
            color: const Color(0xFF2E2E2E),
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${item['name']} (Available: ${item['qty']})',
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 20,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'To remove: ${item['removeQty']}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => _decrementQty(index),
                        icon: const Icon(Icons.remove, color: Colors.white),
                        splashRadius: 20,
                      ),
                      IconButton(
                        onPressed: () => _incrementQty(index),
                        icon: const Icon(Icons.add, color: Colors.white),
                        splashRadius: 20,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildButton({
    required String label,
    required bool filled,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: filled ? Colors.black : Colors.white,
        backgroundColor: filled ? Colors.white : Colors.transparent,
        side: filled ? null : const BorderSide(color: Colors.white),
        textStyle: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Text(label),
    );
  }

  Future<bool> _showConfirmationDialog(String message) async {
    return await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text('Confirm', style: TextStyle(color: Colors.white)),
        content: Text(message, style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    ) ??
        false;
  }
}