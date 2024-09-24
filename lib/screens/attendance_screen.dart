import 'package:flutter/material.dart';
import './location_detail_screen.dart';

class AttendanceScreen extends StatelessWidget {
  final List<String> members = ["Member 1", "Member 2", "Member 3"]; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance')),
      body: ListView.builder(
        itemCount: members.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(members[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.location_on),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationDetailScreen(member: members[index]),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.directions),
                  onPressed: () {
                    Navigator.pushNamed(context, '/routeDetails');
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
