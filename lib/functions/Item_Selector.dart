import 'package:flutter/material.dart';

class ItemSelectorWidget extends StatefulWidget {
  const ItemSelectorWidget({super.key});

  @override
  State<ItemSelectorWidget> createState() => _ItemSelectorWidgetState();
}

class _ItemSelectorWidgetState extends State<ItemSelectorWidget> {
  final List<String> items = [
    'XLR Cables',
    '5 - 5 Cables',
    'Stereo 5 - 3.5',
    'Yamaha DBR',
    'Yamaha DZR',
    'Power Cables',
  ];

  late Map<String, int> quantities;

  @override
  void initState() {
    super.initState();
    quantities = {for (var item in items) item: 0};
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Items',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2C),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              children: items.map((item) => buildRow(item)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRow(String item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFe0e0e0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, color: Color(0xFF030303)),
                  onPressed: () {
                    setState(() {
                      quantities[item] = (quantities[item]! - 1).clamp(0, 999);
                    });
                  },
                ),
                Text(
                  '${quantities[item]}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF030303),
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Color(0xFF030303)),
                  onPressed: () {
                    setState(() {
                      quantities[item] = quantities[item]! + 1;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
