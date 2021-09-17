import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:nativefeatues/helpers/location_helper.dart';
import 'package:nativefeatues/widgets/maps_screen.dart';

class LocationInputWidget extends StatefulWidget {
  final Function(double, double)? onSelectPlace;
  const LocationInputWidget({this.onSelectPlace, Key? key}) : super(key: key);

  @override
  _LocationInputWidgetState createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  String? _previewImageUrl;

  void _showPreview(double lat, double lng) {
    final previewImageUrl =
        LocationHelper.generateLocationPreviewImage(lat, lng);

    setState(() {
      _previewImageUrl = previewImageUrl;
    });
  }

  //TODO: Do the Android gradle configuration
  // Google account billing is required to use the Maps API
  Future<void> _getCurrentLocation() async {
    final locData = await Location().getLocation();
    if (locData != null) {
      _showPreview(locData!.latitude!, locData!.longitude!);
    }
  }

  _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng?>(
      MaterialPageRoute(
          // To show the cross icon instead of back
          fullscreenDialog: true,
          builder: (_) => MapsScreenWidget(
                isSelecting: true,
              )),
    );

    if (selectedLocation == null) {
      return;
    }

    if (widget.onSelectPlace != null) {
      _showPreview(selectedLocation.latitude, selectedLocation.longitude);
      widget.onSelectPlace!(
          selectedLocation.latitude, selectedLocation.longitude);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? Text(
                  'No location chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              label: Text('Current Location'),
              onPressed: _getCurrentLocation,
              icon: Icon(Icons.location_on),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              label: Text('Select on map'),
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              textColor: Theme.of(context).primaryColor,
            )
          ],
        )
      ],
    );
  }
}
