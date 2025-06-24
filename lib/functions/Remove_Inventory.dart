import 'package:flutter/material.dart';

class RemoveInventoryPage extends StatefulWidget {
  const RemoveInventoryPage({super.key});

  @override
  State<RemoveInventoryPage> createState() => _RemoveInventoryPageState();
}

class _RemoveInventoryPageState extends State<RemoveInventoryPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _selectedItems = [
    {'name': 'XLR Cables', 'qty': 4},
    {'name': '5 - 5 Cables', 'qty': 5},
    {'name': 'Stereo 5 - 3.5', 'qty': 1},
    {'name': 'Yamaha DBR', 'qty': 2},
    {'name': 'Yamaha DZR', 'qty': 0},
    {'name': 'Power Cables', 'qty': 2},
  ];

  bool _removed = false;

  // Responsive sizing
  late double screenWidth, screenHeight;
  static const designWidth = 440.0;
  static const designHeight = 956.0;
  double scaleW(double px) => px / designWidth * screenWidth;
  double scaleH(double px) => px / designHeight * screenHeight;

  void _addItem(String name) {
    if (name.isEmpty) return;
    if (!_selectedItems.any((item) => item['name'] == name)) {
      setState(() {
        _selectedItems.add({'name': name, 'qty': 0});
        _searchController.clear();
      });
    }
  }

  void _incrementQty(int index) {
    setState(() => _selectedItems[index]['qty']++);
  }

  void _decrementQty(int index) {
    setState(() {
      if (_selectedItems[index]['qty'] > 0) {
        _selectedItems[index]['qty']--;
      }
    });
  }

  void _confirmRemoval() {
    setState(() {
      _removed = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _removed = false;
        _selectedItems.clear();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'REMOVE ITEMS',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.account_circle_outlined, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: scaleW(32),
          vertical: scaleH(20),
        ),
        child: Column(
          children: [
            _buildSearchBox(),
            SizedBox(height: scaleH(20)),
            Expanded(child: _buildItemList()),
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
              _buildButton(
                label: 'CONFIRM REMOVAL',
                filled: true,
                onPressed: _confirmRemoval,
              ),
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
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 20,
          color: Colors.white,
        ),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFF2E2E2E),
          hintText: 'Search item name...',
          hintStyle: const TextStyle(color: Colors.white60),
          prefixIcon: const Icon(Icons.search, color: Colors.white60),
          suffixIcon: IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => _addItem(_searchController.text.trim()),
          ),
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
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: scaleH(56),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item['name'],
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 20,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => _decrementQty(index),
                    icon: const Icon(Icons.remove, color: Colors.white),
                    splashRadius: 20,
                  ),
                  Text(
                    '${item['qty']}',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () => _incrementQty(index),
                    icon: const Icon(Icons.add, color: Colors.white),
                    splashRadius: 20,
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Text(label),
    );
  }
}
