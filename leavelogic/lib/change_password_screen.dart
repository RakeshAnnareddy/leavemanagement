import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmNewPasswordController;

  @override
  void initState() {
    super.initState();
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _currentPasswordController,
              decoration: InputDecoration(
                labelText: 'Current Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(
                labelText: 'New Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _confirmNewPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _handleChangePassword();
              },
              child: Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleChangePassword() {
    // ignore: unused_local_variable
    String currentPassword = _currentPasswordController.text;
    String newPassword = _newPasswordController.text;
    String confirmNewPassword = _confirmNewPasswordController.text;

    // Validate passwords
    if (newPassword != confirmNewPassword) {
      // Show password mismatch error
      _showSnackBar('New password and confirm password do not match.');
      return;
    }

    // Perform password change logic
    // Example: AuthService.changePassword(currentPassword, newPassword);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
