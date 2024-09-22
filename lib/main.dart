import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import './screens/attendance_screen.dart';
import './screens/location_detail_screen.dart';
import './screens/route_details_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/attendance': (context) => AttendanceScreen(),
        '/locationDetail': (context) {
          final member = ModalRoute.of(context)?.settings.arguments as String;
          return LocationDetailScreen(member: member);
        },
        '/routeDetails': (context) {
          // Define start and end locations for the route
          LatLng startLocation = LatLng(37.7749, -122.4194); // Example: San Francisco
          LatLng endLocation = LatLng(34.0522, -118.2437);   // Example: Los Angeles

          // Define stop locations (these are stops where the user paused for more than 10 minutes)
          List<LatLng> stopLocations = [
            LatLng(36.7783, -119.4179),  // Example stop (midpoint)
          ];

          return RouteDetailsScreen(
            startLocation: startLocation,
            endLocation: endLocation,
            stopLocations: stopLocations, // List of stop points
          );
        },
      },
    );
  }
}
