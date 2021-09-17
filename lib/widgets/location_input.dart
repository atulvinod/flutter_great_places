import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:location/location.dart';
import 'package:nativefeatues/helpers/location_helper.dart';

class LocationInputWidget extends StatefulWidget {
  const LocationInputWidget({Key? key}) : super(key: key);

  @override
  _LocationInputWidgetState createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  String? _previewImageUrl;

  //TODO: Do the Android gradle configuration
  // Google account billing is required to use the Maps API
  Future<void> _getCurrentLocation() async {
    final locData = await Location().getLocation();
    final previewImageUrl = LocationHelper.generateLocationPreviewImage(
        locData.latitude!, locData.longitude!);

    setState(() {
      _previewImageUrl = previewImageUrl;
    });
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
              onPressed: () {},
              icon: Icon(Icons.map),
              textColor: Theme.of(context).primaryColor,
            )
          ],
        )
      ],
    );
  }
}
