import 'package:flutter/material.dart';
import 'package:leavelogic/auth/otpverification_page.dart'; // Import your OTP verification page widget here

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Forgot Password',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Please enter the phone number we will send the OTP to:',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            Container(
              width: 300.0, // Adjust the width as needed
              height: 50.0, // Adjust the height as needed
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration.collapsed(
                    hintText: 'Enter your phone number',
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to OTPVerificationPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OTPVerificationPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Fill with blue color
              ),
              child: Text('Continue', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
