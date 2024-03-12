// dashboard_screen.dart

import 'package:flutter/material.dart';
import 'package:leavelogic/change_password_screen.dart';
import 'home_screen.dart';
import 'leave_history.dart';
import 'settings_screen.dart';
import 'profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(numberOfLeaveRequests: 5, remainingLeaves: 0),
    LeaveApplicationPage(),
    SettingsScreen(),
    ProfileScreen(),
    ChangePasswordScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave Logic'),
        backgroundColor: Colors.blue, // Set the background color here
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 10,
        items: [
          _buildNavBarItem(icon: Icons.home, label: 'Home'),
          _buildNavBarItem(icon: Icons.calendar_today, label: 'Leave History'),
          _buildNavBarItem(icon: Icons.settings, label: 'Settings'),
          _buildNavBarItem(icon: Icons.person, label: 'Profile'),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavBarItem({required IconData icon, required String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
