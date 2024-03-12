import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LeaveApplicationPage extends StatefulWidget {
  @override
  _LeaveApplicationPageState createState() => _LeaveApplicationPageState();
}

class _LeaveApplicationPageState extends State<LeaveApplicationPage> {
  List<dynamic> leaveApplications = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchLeaveApplications();
  }

  Future<void> fetchLeaveApplications() async {
    try {
      final response =await http.get(Uri.parse('http://192.168.73.58:8000/api/fetch_all_leaves'));
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        setState(() {
          leaveApplications = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to fetch leave applications';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Network error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave Applications'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : leaveApplications.isEmpty
                  ? Center(child: Text('No leave applications found'))
                  : ListView.builder(
                      itemCount: leaveApplications.length,
                      itemBuilder: (context, index) {
                        final leaveApplication = leaveApplications[index];
                        return ListTile(
                          title: Text('Type: ${leaveApplication['leaveType']}'),
                          subtitle: Text(
                              'Subject: ${leaveApplication['leaveSubject']}\nStart Date: ${leaveApplication['startDate']}\nEnd Date: ${leaveApplication['endDate']}'),
                          trailing: Text('Status: ${leaveApplication['status']}'),
                        );
                      },
                    ),
    );
  }
}
