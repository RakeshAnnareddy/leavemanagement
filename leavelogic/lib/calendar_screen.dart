import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LeaveHistory extends StatefulWidget {
  @override
  _LeaveHistoryState createState() => _LeaveHistoryState();
}

class _LeaveHistoryState extends State<LeaveHistory> {
  List<dynamic> leaveApplications = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://192.168.144.58:8000/api/get-details'));
    if (response.statusCode == 200) {
      setState(() {
        leaveApplications = json.decode(response.body)['leave_applications'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Leave History'),
        ),
        body: leaveApplications.isEmpty
            ? Center(child: Text('No leaves are applied'))
            : ListView.builder(
                itemCount: leaveApplications.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          leaveApplications[index]['title'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(leaveApplications[index]['description']),
                        // Add more fields as needed
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
