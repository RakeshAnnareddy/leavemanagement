import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LeaveApplyPage extends StatefulWidget {
  final String leaveType;

  LeaveApplyPage({required this.leaveType});

  @override
  _LeaveApplyPageState createState() => _LeaveApplyPageState();
}

class _LeaveApplyPageState extends State<LeaveApplyPage> {
  DateTime? _startDate;
  DateTime? _endDate;
  TextEditingController _leaveSubjectController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Leave Apply Form for ${widget.leaveType}',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 20),
              _buildLeaveSubjectContainer(),
              SizedBox(height: 20),
              _buildLeaveDatesContainer(),
              SizedBox(height: 20),
              _buildLeaveTypeContainer(),
              SizedBox(height: 20),
              _buildDescriptionContainer(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add logic to handle leave application submission
                  submitLeaveApplication();
                },
                child: Text(
                  'Apply for Leave',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeaveSubjectContainer() {
    return Container(
      width: 350,
      child: TextField(
        controller: _leaveSubjectController,
        maxLength: 20,
        style: TextStyle(fontSize: 18.0),
        decoration: InputDecoration(
          labelText: 'Leave Subject',
        ),
      ),
    );
  }

  Widget _buildLeaveDatesContainer() {
    return Container(
      width: 350,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _selectDate(context, true),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Start Date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(
                  _startDate != null
                      ? "${_startDate!.toLocal()}".split(' ')[0]
                      : "Select Date",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: GestureDetector(
              onTap: () => _selectDate(context, false),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'End Date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(
                  _endDate != null
                      ? "${_endDate!.toLocal()}".split(' ')[0]
                      : "Select Date",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _selectDate(BuildContext context, bool isStartDate) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 40), //increase years
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  Widget _buildLeaveTypeContainer() {
    return Container(
      width: 350,
      child: Text(
        'Leave Type: ${widget.leaveType}',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }

  Widget _buildDescriptionContainer() {
    return Container(
      width: 350,
      child: TextField(
        controller: _descriptionController,
        maxLength: 100,
        maxLines: 2,
        style: TextStyle(fontSize: 18.0),
        decoration: InputDecoration(
          labelText: 'Description',
        ),
      ),
    );
  }

  void submitLeaveApplication() async {
    try {
      // Check if start date or end date is null
      if (_startDate == null || _endDate == null) {
        print('Please select start and end dates');
        return;
      }

      // Prepare data to be sent to the Flask backend
      Map<String, dynamic> data = {
        'leaveType': widget.leaveType,
        'leaveSubject': _leaveSubjectController.text,
        'startDate': _startDate!.toLocal().toString().split(' ')[0],
        'endDate': _endDate!.toLocal().toString().split(' ')[0],
        'description': _descriptionController.text,
      };

      // Make HTTP POST request to the Flask backend
      final response = await http.post(
        Uri.parse('http://192.168.144.58:8000/api/apply-leave'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // Show a popup message when leave application is submitted successfully
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Leave Application Submitted'),
              content: Text(
                  'Your leave application has been submitted successfully.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    // Optionally, you can navigate to another screen or perform any other action.
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        print('Failed to submit leave application');
        // Handle the error, show a message, or navigate to an error screen.
      }
    } on http.ClientException catch (e) {
      print('ClientException: $e');
      // Handle the client exception (e.g., network issues)
    } catch (error) {
      print('Error: $error');
      // Handle other exceptions
    }
  }
}
