import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';  // For date formatting

class LocationDetailScreen extends StatefulWidget {
  final String member;

  LocationDetailScreen({required this.member});

  @override
  _LocationDetailScreenState createState() => _LocationDetailScreenState();
}

class _LocationDetailScreenState extends State<LocationDetailScreen> {
  DateTime selectedDate = DateTime.now(); // Default to today's date
  List<LatLng> visitedLocations = [
    LatLng(37.7749, -122.4194),  // San Francisco
    LatLng(37.7849, -122.4294),  // Example point 2
    LatLng(37.7949, -122.4394),  // Example point 3
  ]; // Dummy location data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.member}\'s Location'),
        actions: [
          TextButton(
            onPressed: _selectDate,
            child: Text('Change', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Google Map displaying visited locations
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: visitedLocations.first,
              zoom: 14.0,
            ),
            markers: _buildMarkers(),
            polylines: _buildPolylines(),
          ),

          // DraggableScrollableSheet for showing the visited location timeline
          DraggableScrollableSheet(
            initialChildSize: 0.3,  // Initial size of the sheet when it appears
            minChildSize: 0.1,  // Minimum size when collapsed
            maxChildSize: 0.6,  // Maximum size when fully expanded
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: ListView.builder(
                  controller: scrollController,  // Allows scrolling within the draggable sheet
                  itemCount: visitedLocations.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("Location ${index + 1}"),
                      subtitle: Text("Visited at ${DateFormat('HH:mm').format(selectedDate)}"),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Builds the markers for visited locations on the map
  Set<Marker> _buildMarkers() {
    return visitedLocations.map((location) {
      return Marker(
        markerId: MarkerId(location.toString()),
        position: location,
        infoWindow: InfoWindow(title: "Visited Location"),
      );
    }).toSet();
  }

  // Builds the polylines (routes) between visited locations
  Set<Polyline> _buildPolylines() {
    return {
      Polyline(
        polylineId: PolylineId('route'),
        points: visitedLocations,
        color: Colors.blue,
        width: 5,
      ),
    };
  }

  // Allows the user to select a different date to view location data for that day
  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        // Update the locations list based on the selected date
      });
  }
}
