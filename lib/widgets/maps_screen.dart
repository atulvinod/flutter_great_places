import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nativefeatues/models/place.dart';

class MapsScreenWidget extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;
  const MapsScreenWidget(
      {this.initialLocation = const PlaceLocation(37.422, -144, "Google plex"),
      Key? key,
      // Determines if we are in readonly mode or selecting mode
      this.isSelecting = false})
      : super(key: key);

  @override
  _MapsScreenWidgetState createState() => _MapsScreenWidgetState();
}

class _MapsScreenWidgetState extends State<MapsScreenWidget> {
  LatLng? _pickedLocation;
  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select location"), actions: [
        if (widget.isSelecting)
          IconButton(
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
              icon: Icon(Icons.check))
      ]),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          zoom: 16,
          target:
              LatLng(widget.initialLocation.lat, widget.initialLocation.long),
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: _pickedLocation == null
            ? {}
            : {
                Marker(
                    markerId: MarkerId(DateTime.now().toIso8601String()),
                    position: _pickedLocation!)
              },
      ),
    );
  }
}
