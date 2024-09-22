import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' as math;

class RouteDetailsScreen extends StatelessWidget {
  final LatLng startLocation;
  final LatLng endLocation;
  final List<LatLng> stopLocations; // List of stop points

  RouteDetailsScreen({
    required this.startLocation,
    required this.endLocation,
    required this.stopLocations, // Added stopLocations here
  });

  // Dummy data for visited locations
  final List<Map<String, dynamic>> visitedLocations = [
    {
      'location': LatLng(37.7749, -122.4194),  // Start Location
      'timestamp': DateTime(2023, 9, 21, 8, 30),  // Example timestamp
    },
    {
      'location': LatLng(37.7849, -122.4294),  // End Location
      'timestamp': DateTime(2023, 9, 21, 10, 45),  // Example timestamp
    },
  ];

  // Calculate the total duration between the first and last locations
  Duration calculateTotalDuration() {
    DateTime startTime = visitedLocations.first['timestamp'];
    DateTime endTime = visitedLocations.last['timestamp'];
    return endTime.difference(startTime);  // This calculates the total duration
  }

  // Format the duration to a human-readable string
  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);  // Minutes remaining after hours are extracted
    return '$hours hours, $minutes minutes';
  }

  // Haversine formula to calculate distance between two lat/long points
  double calculateDistance(LatLng start, LatLng end) {
    const R = 6371; // Radius of the Earth in kilometers
    double lat1 = start.latitude;
    double lon1 = start.longitude;
    double lat2 = end.latitude;
    double lon2 = end.longitude;

    double dLat = _degreesToRadians(lat2 - lat1);
    double dLon = _degreesToRadians(lon2 - lon1);

    double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_degreesToRadians(lat1)) *
            math.cos(_degreesToRadians(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);

    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return R * c; // Distance in kilometers
  }

  double _degreesToRadians(double degrees) {
    return degrees * math.pi / 180;
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the total duration of the trip
    Duration totalDuration = calculateTotalDuration();

    // Calculate the total distance (including stop points if needed)
    double totalDistance = calculateDistance(startLocation, endLocation);

    return Scaffold(
      appBar: AppBar(
        title: Text('Route Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: startLocation,
                zoom: 14.0,
              ),
              polylines: _buildPolylines(),
              markers: _buildStopMarkers(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Start: ${startLocation.latitude}, ${startLocation.longitude}'),
                Text('End: ${endLocation.latitude}, ${endLocation.longitude}'),
                Text('Total KMs: ${totalDistance.toStringAsFixed(2)} KM'),  // Display total distance here
                Text('Total Duration: ${formatDuration(totalDuration)}'),  // Display total duration here
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Define the polyline for the route
  Set<Polyline> _buildPolylines() {
    return {
      Polyline(
        polylineId: PolylineId('route'),
        points: [startLocation, endLocation],
        color: Colors.green,
        width: 5,
      ),
    };
  }

  // Add markers for start, stop, and end locations
  Set<Marker> _buildStopMarkers() {
    Set<Marker> markers = {
      Marker(
        markerId: MarkerId('start'),
        position: startLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: "Start Location"),
      ),
      Marker(
        markerId: MarkerId('end'),
        position: endLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: "End Location"),
      ),
    };

    // Add markers for stop locations
    for (int i = 0; i < stopLocations.length; i++) {
      markers.add(
        Marker(
          markerId: MarkerId('stop_$i'),
          position: stopLocations[i],
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          infoWindow: InfoWindow(title: "Stop Location $i"),
        ),
      );
    }

    return markers;
  }
}
