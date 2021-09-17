import 'dart:io';

class Place {
  final String id;
  final String title;
  final PlaceLocation? location;
  final File image;
  Place(
      {required this.id,
      required this.title,
      this.location,
      required this.image});
}

class PlaceLocation {
  final double lat;
  final double lng;
  final String? address;

  const PlaceLocation(this.lat, this.lng, this.address);
}
