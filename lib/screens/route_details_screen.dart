import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteDetailsScreen extends StatelessWidget {
  final LatLng startLocation;
  final LatLng endLocation;

  RouteDetailsScreen({required this.startLocation, required this.endLocation});

  @override
  Widget build(BuildContext context) {
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Start: ${startLocation.latitude}, ${startLocation.longitude}'),
                Text('End: ${endLocation.latitude}, ${endLocation.longitude}'),
                Text('Total KMs: X'), // Replace X with actual distance logic
                Text('Total Duration: Y'), // Replace Y with actual duration logic
              ],
            ),
          ),
        ],
      ),
    );
  }

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
}
