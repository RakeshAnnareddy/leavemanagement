// home_screen.dart

import 'package:flutter/material.dart';
import 'leave_apply_page.dart'; // Import your leave apply page file

class HomeScreen extends StatelessWidget {
  final int remainingLeaves;
  final int numberOfLeaveRequests;

  HomeScreen({required this.remainingLeaves, required this.numberOfLeaveRequests});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave Dashboard'),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Align content in the middle vertically
            children: [
              CustomContainer(
                remainingLeaves: remainingLeaves,
                totalLeaves: 31,
                leaveType: 'Annual Leave',
                onPressed: () {
                  _navigateToLeaveApplyPage(context, 'Annual Leave');
                },
              ),
              SizedBox(height: 16.0),
              CustomContainer(
                remainingLeaves: remainingLeaves,
                totalLeaves: 12,
                leaveType: 'Casual Leave',
                onPressed: () {
                  _navigateToLeaveApplyPage(context, 'Casual Leave');
                },
              ),
              SizedBox(height: 16.0),
              CustomContainer(
                remainingLeaves: remainingLeaves,
                totalLeaves: 5,
                leaveType: 'Sick Leave',
                onPressed: () {
                  _navigateToLeaveApplyPage(context, 'Sick Leave');
                },
              ),
              SizedBox(height: 16.0),
              CustomContainer(
                remainingLeaves: remainingLeaves,
                totalLeaves: 5,
                leaveType: 'Paid Leave',
                onPressed: () {
                  _navigateToLeaveApplyPage(context, 'Paid Leave');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToLeaveApplyPage(BuildContext context, String leaveType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LeaveApplyPage(leaveType: leaveType),
      ),
    );
  }
}


class CustomContainer extends StatelessWidget {
  final int remainingLeaves;
  final int totalLeaves;
  final String leaveType;
  final VoidCallback onPressed;

  CustomContainer({
    required this.remainingLeaves,
    required this.totalLeaves,
    required this.leaveType,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 300.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            leaveType,
            style: TextStyle(fontSize: 18.0),
          ),
          Text(
            '$remainingLeaves/$totalLeaves',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: onPressed,
                child: Text('Apply'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}