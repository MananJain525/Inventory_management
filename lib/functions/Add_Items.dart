import 'package:flutter/material.dart';

class AddItemsPage extends StatefulWidget {
  const AddItemsPage({super.key});

  @override
  State<AddItemsPage> createState() => _AddItemsPageState();
}

class _AddItemsPageState extends State<AddItemsPage> {
  // Controllers and state variables
  final TextEditingController itemNameController = TextEditingController();
  String? selectedItemType;
  String? selectedLocation;
  bool showSuccessMessage = false;

  // Dropdown options
  final List<String> itemTypes = [
    'Microphones',
    'Cables',
    'Speakers',
    'Mixers',
    'Miscellaneous',
  ];

  final List<String> locations = [
    'Auditorium',
    'SAC',
    'XYZ Common Room',
    'Workshop Grounds',
    'CC Lab',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Reference design dimensions (for scale if needed)
    const designWidth = 440.0;
    const designHeight = 956.0;

    // Scaling helpers (if needed for consistency)
    double scaleW(double px) => px / designWidth * screenWidth;
    double scaleH(double px) => px / designHeight * screenHeight;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        title: const Text(
          'ADD ITEMS',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: scaleW(32),
            right: scaleW(32),
            top: scaleH(100),
            bottom: scaleH(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ITEM NAME
              _buildLabel('ITEM NAME'),
              SizedBox(height: scaleH(6)),
              _buildTextField(controller: itemNameController),

              SizedBox(height: scaleH(40)),

              // ITEM TYPE (Dropdown)
              _buildLabel('ITEM TYPE'),
              SizedBox(height: scaleH(6)),
              _buildItemTypeDropdown(),

              SizedBox(height: scaleH(40)),

              // LOCATION (Dropdown)
              _buildLabel('LOCATION'),
              SizedBox(height: scaleH(6)),
              _buildLocationDropdown(),

              SizedBox(height: scaleH(60)),

              // ACTION BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildButton(
                    label: 'Edit',
                    onPressed: () {
                      // TODO: Implement Edit functionality if needed
                    },
                    filled: false,
                  ),
                  _buildButton(
                    label: 'Confirm',
                    onPressed: () {
                      // Validate inputs and show success message
                      if (_validateInputs()) {
                        setState(() => showSuccessMessage = true);
                      }
                    },
                    filled: true,
                  ),
                ],
              ),

              // SUCCESS MESSAGE
              if (showSuccessMessage)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'ADDED SUCCESSFULLY!',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  // Validate input fields
  bool _validateInputs() {
    return itemNameController.text.isNotEmpty &&
        selectedItemType != null &&
        selectedLocation != null;
  }

  // Section label builder
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Roboto',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 1.1,
      ),
    );
  }

  // General purpose text field
  Widget _buildTextField({required TextEditingController controller}) {
    return SizedBox(
      width: double.infinity,
      height: 53, // Fixed height per design
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 24,
          color: Colors.white,
        ),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFF2E2E2E),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none,
          ),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
      ),
    );
  }

  // Item Type Dropdown
  Widget _buildItemTypeDropdown() {
    return SizedBox(
      width: double.infinity,
      height: 53,
      child: DropdownButtonFormField<String>(
        value: selectedItemType,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        dropdownColor: const Color(0xFF2E2E2E),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFF2E2E2E),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none,
          ),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 24,
          color: Colors.white,
        ),
        items: itemTypes.map((type) {
          return DropdownMenuItem<String>(
            value: type,
            child: Text(type),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedItemType = value;
          });
        },
      ),
    );
  }

  // Location Dropdown
  Widget _buildLocationDropdown() {
    return SizedBox(
      width: double.infinity,
      height: 53,
      child: DropdownButtonFormField<String>(
        value: selectedLocation,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        dropdownColor: const Color(0xFF2E2E2E),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFF2E2E2E),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none,
          ),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 24,
          color: Colors.white,
        ),
        items: locations.map((loc) {
          return DropdownMenuItem<String>(
            value: loc,
            child: Text(loc),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedLocation = value;
          });
        },
      ),
    );
  }

  // Custom styled button (Edit/Confirm)
  Widget _buildButton({
    required String label,
    required VoidCallback onPressed,
    required bool filled,
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
