import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationDetailScreen extends StatelessWidget {
  final String member;

  LocationDetailScreen({required this.member});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$member\'s Location')),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(37.7749, -122.4194), // Sample coordinates
                zoom: 14.0,
              ),
              markers: _buildMarkers(),
              polylines: _buildPolylines(), // Route lines
            ),
          ),
          _buildLocationList(),
        ],
      ),
    );
  }

  Set<Marker> _buildMarkers() {
    return {
      Marker(
        markerId: MarkerId('current'),
        position: LatLng(37.7749, -122.4194), // Sample coordinates
        infoWindow: InfoWindow(title: "Current Location"),
      ),
    };
  }

  Set<Polyline> _buildPolylines() {
    return {
      Polyline(
        polylineId: PolylineId('route'),
        points: [LatLng(37.7749, -122.4194), LatLng(37.7849, -122.4294)], // Sample route
        color: Colors.blue,
        width: 5,
      ),
    };
  }

  Widget _buildLocationList() {
    return Expanded(
      child: ListView(
        children: [
          ListTile(
            title: Text("Location 1"),
            subtitle: Text("Visited at 10:00 AM"),
          ),
          ListTile(
            title: Text("Location 2"),
            subtitle: Text("Visited at 11:00 AM"),
          ),
        ],
      ),
    );
  }
}
