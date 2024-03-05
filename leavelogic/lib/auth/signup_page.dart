import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signUp(BuildContext context) async {
    final String apiUrl = 'http://192.168.152.159:8000/signup';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': usernameController.text,
        'email': emailController.text,
        'phone_number': phoneNumberController.text,
        'password': passwordController.text,
      }),
    );

    if (response.statusCode == 201) {
      // Signup successful
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Signup Successful!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      // Clear the text fields after successful signup
      usernameController.clear();
      emailController.clear();
      phoneNumberController.clear();
      passwordController.clear();
    } else {
      // Signup failed
      print('Signup failed: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Signup',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              buildTextField(usernameController, 'Enter your username'),
              SizedBox(height: 20),
              buildTextField(emailController, 'Enter your email'),
              SizedBox(height: 20),
              buildTextField(phoneNumberController, 'Enter your phone number'),
              SizedBox(height: 20),
              buildTextField(passwordController, 'Enter your password', isObscure: true),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => signUp(context), // Call signUp function
                child: Text('Signup'),
              ),
              SizedBox(height: 10),
              Text(
                'Already have an account?',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              SizedBox(height: 5),
              TextButton(
                onPressed: () {
                  // Navigate to login page
                },
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String hintText, {bool isObscure = false}) {
    return Container(
      width: 300,
      height: 50,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        decoration: InputDecoration.collapsed(hintText: hintText),
      ),
    );
  }
}
