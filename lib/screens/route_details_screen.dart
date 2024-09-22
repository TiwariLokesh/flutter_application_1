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
                Text('Total KMs: X'),  // Calculate the actual distance
                Text('Total Duration: Y'),  // Calculate actual duration
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

  Set<Marker> _buildStopMarkers() {
    // Add red dot markers for stop points along the route
    return {
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
  }
}
