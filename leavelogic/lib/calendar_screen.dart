import 'package:flutter/material.dart';

// Model class for leave entry
class LeaveEntry {
  final String leaveType;
  final String fromDate;
  final String toDate;
  final String status;

  LeaveEntry({
    required this.leaveType,
    required this.fromDate,
    required this.toDate,
    required this.status,
  });
}

// Widget to display leave history details
class LeaveHistoryDetailsWidget extends StatelessWidget {
  final LeaveEntry leaveEntry;

  LeaveHistoryDetailsWidget({required this.leaveEntry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Leave Type: ${leaveEntry.leaveType}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.0),
          Text('From: ${leaveEntry.fromDate}'),
          Text('To: ${leaveEntry.toDate}'),
          SizedBox(height: 5.0),
          Text('Status: ${leaveEntry.status}'),
        ],
      ),
    );
  }
}

// Main widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sample leave entries
    List<LeaveEntry> leaveEntries = [
      LeaveEntry(
        leaveType: 'Sick Leave',
        fromDate: '2024-03-01',
        toDate: '2024-03-03',
        status: 'Approved',
      ),
      LeaveEntry(
        leaveType: 'Vacation Leave',
        fromDate: '2024-02-28',
        toDate: '2024-03-02',
        status: 'Pending',
      ),
      LeaveEntry(
        leaveType: 'Personal Leave',
        fromDate: '2024-02-25',
        toDate: '2024-02-25',
        status: 'Rejected',
      ),
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Leave History'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: leaveEntries
                .map((leaveEntry) => LeaveHistoryDetailsWidget(
                      leaveEntry: leaveEntry,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}
