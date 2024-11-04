import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Hello',
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
                      'Atharv Tiwari',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '+91 1234567890',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(
                      'assets/user_avatar.png'), // Replace with user image
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
                    label: 'Change Password',
                    onTap: () {
                      // Handle navigation to Change Password
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
                      // Handle navigation to Account Settings
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
  Widget _buildProfileOption(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(label),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
      onTap: onTap,
    );
  }

  // Widget for action buttons like 'My Bookings', 'Help & support'
  Widget _buildActionButton(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
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
