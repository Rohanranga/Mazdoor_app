import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mazdoor_user/user_details_page.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String? userName;
  String? phoneNumber;
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  // Fetch user data from Firestore using the logged-in user's phone number
  Future<void> _fetchUserData() async {
    try {
      String? phone = FirebaseAuth.instance.currentUser?.phoneNumber;
      if (phone != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(phone)
            .get();

        if (userDoc.exists) {
          setState(() {
            userName = userDoc['name'];
            phoneNumber = phone;
            profileImageUrl = userDoc['profileImageUrl'];
          });
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Hello, ${userName ?? 'User'}',
          style: TextStyle(color: Colors.orange),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User details section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName ?? 'Loading...',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      phoneNumber ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: profileImageUrl != null
                      ? NetworkImage(profileImageUrl!)
                      : AssetImage('assets/user_avatar.png')
                          as ImageProvider, // Default image if no profile image is found
                ),
              ],
            ),
            SizedBox(height: 20),
            // Action buttons: My Bookings and Help & Support
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  icon: Icons.calendar_today,
                  label: 'My Bookings',
                  onTap: () {
                    // Handle navigation to My Bookings
                  },
                ),
                _buildActionButton(
                  icon: Icons.help_outline,
                  label: 'Help & support',
                  onTap: () {
                    // Handle navigation to Help & Support
                  },
                ),
              ],
            ),
            SizedBox(height: 30),
            Divider(thickness: 1, color: Colors.grey[300]),
            SizedBox(height: 20),
            // Settings and options list
            Expanded(
              child: ListView(
                children: [
                  _buildProfileOption(
                    icon: Icons.star_border,
                    label: 'Preferences',
                    onTap: () {
                      // Handle navigation to Preferences
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.lock_outline,
                    label: 'Change Phonenumber',
                    onTap: () {
                      // Handle navigation to Change Phone number
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.notifications_outlined,
                    label: 'Notifications',
                    onTap: () {
                      // Handle navigation to Notifications
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.payment_outlined,
                    label: 'Payment Methods',
                    onTap: () {
                      // Handle navigation to Payment Methods
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.settings_outlined,
                    label: 'Account Settings',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserDetailsScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
    );
  }

  // Widget for profile options like 'Change Password', 'Notifications', etc.
  Widget _buildProfileOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(label),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
      onTap: onTap,
    );
  }

  // Widget for action buttons like 'My Bookings', 'Help & support'
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(icon, size: 30, color: Colors.black),
            SizedBox(height: 8),
            Text(label, style: TextStyle(fontSize: 16, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
