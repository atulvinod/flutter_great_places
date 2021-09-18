import 'dart:convert';

import 'package:http/http.dart' as http;

//TODO : Google API Key is required
const GOOGLE_API_KEY = '';

class LocationHelper {
  static String generateLocationPreviewImage(double lat, double long) {
    //TODO: Get Google Map image using url , check docs
    return '-- Location Preview URL --';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final googleGeoCodingUrl = '-- Geocoding Url -- ';
    final response = await http.get(Uri.parse(googleGeoCodingUrl));
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
