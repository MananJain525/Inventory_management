import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBack;
  final VoidCallback onProfile;

  const SimpleAppBar({
    Key? key,
    required this.title,
    required this.onBack,
    required this.onProfile,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF181818),
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: onBack,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      actions: [
        StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            return IconButton(
              icon: _buildProfileWidget(snapshot.data),
              onPressed: onProfile,
            );
          },
        ),
      ],
    );
  }
  Widget _buildProfileWidget(User? user) {
    if (user?.photoURL != null) {
      return CircleAvatar(
        radius: 16,
        backgroundImage: NetworkImage(user!.photoURL!),
        backgroundColor: Colors.grey[300],
      );
    } else {
      // Fallback to default icon if no profile image
      return const Icon(Icons.person, color: Colors.white);
    }
  }
}