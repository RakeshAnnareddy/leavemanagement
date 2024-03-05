import 'package:flutter/material.dart';
import 'package:leavelogic/change_password_screen.dart';
import 'package:leavelogic/edit_profile.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          _buildSettingsListItem(
            title: 'Edit Profile',
            icon: Icons.person,
            onTap: () {
              Navigator.push(
                context,
                 MaterialPageRoute(builder: (context) => EditProfileScreen()),
                 );
            },
          ),
          _buildSettingsListItem(
            title: 'Change Password',
            icon: Icons.lock,
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
              );
            },
          ),
          _buildSettingsListItem(
            title: 'Notifications',
            icon: Icons.notifications,
            onTap: () {
              // Navigate to notifications settings screen
            },
          ),
          _buildSettingsListItem(
            title: 'Privacy Policy',
            icon: Icons.security,
            onTap: () {
              // Navigate to privacy policy screen
            },
          ),
          _buildSettingsListItem(
            title: 'Terms of Service',
            icon: Icons.description,
            onTap: () {
              // Navigate to terms of service screen
            },
          ),
          _buildSettingsListItem(
            title: 'Contact Us',
            icon: Icons.mail,
            onTap: () {
              // Navigate to contact us screen
            },
          ),
          _buildSettingsListItem(
            title: 'Log Out',
            icon: Icons.exit_to_app,
            onTap: () {
              // Log out the user
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsListItem({required String title, required IconData icon, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: ListTile(
          title: Text(title),
          leading: Icon(icon),
          onTap: onTap,
        ),
      ),
    );
  }
}
