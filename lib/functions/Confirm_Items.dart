import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_management_system/screens/Dashboard_Admin.dart';
import 'package:inventory_management_system/widgets/AppBar.dart';

import 'Add_Items.dart';

class ConfirmItemsPage extends StatelessWidget {
  final String itemName;
  final String itemType;
  final String location;
  final int quantity;

  const ConfirmItemsPage({
    super.key,
    required this.itemName,
    required this.itemType,
    required this.location,
    required this.quantity,
  });

  Future<void> _addItemToFirestore(BuildContext context) async {
    final docId = '${itemName.trim()}_${itemType.trim()}';
    final docRef = FirebaseFirestore.instance
        .collection('locations')
        .doc(location)
        .collection('inventory')
        .doc(docId);

    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      // Item already exists — update quantity
      final currentQty = docSnapshot.data()?['Quantity'] ?? 0;
      await docRef.update({
        'Quantity': currentQty + quantity,
      });
    } else {

      await docRef.set({
        'Item Name': itemName,
        'Type': itemType,
        'Quantity': quantity,
      });
    }

    _showSuccessDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: SimpleAppBar(
        title: 'ADD ITEMS',
        onBack: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashboardAdmin()),
          );
        },
        onProfile: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel('ITEM NAME'),
            _buildDisplayBox(itemName),

            const SizedBox(height: 24),
            _buildLabel('ITEM TYPE'),
            _buildDisplayBox(itemType),

            const SizedBox(height: 24),
            _buildLabel('LOCATION'),
            _buildDisplayBox(location),

            const SizedBox(height: 24),
            _buildLabel('QUANTITY'),
            _buildDisplayBox(quantity.toString()),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildButton(
                  label: 'Edit',
                  onPressed: () => Navigator.pop(context),
                  filled: false,
                ),
                _buildButton(
                  label: 'Confirm',
                  onPressed: () => _addItemToFirestore(context),
                  filled: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Text(
    text,
    style: const TextStyle(
      fontFamily: 'Roboto',
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );

  Widget _buildDisplayBox(String value) => Container(
    width: double.infinity,
    height: 53,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      color: const Color(0xFF2E2E2E),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      value,
      style: const TextStyle(
        fontFamily: 'Roboto',
        fontSize: 24,
        color: Colors.white,
      ),
    ),
  );

  Widget _buildButton({
    required String label,
    required VoidCallback onPressed,
    required bool filled,
  }) =>
      ElevatedButton(
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Text(label),
      );

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'ADDED SUCCESSFULLY!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Inter',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const AddItemsPage()),
                    (route) => false,
              );
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

}
