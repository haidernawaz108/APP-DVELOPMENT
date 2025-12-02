import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  // Permission check
  Future<bool> _handlePermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  Future<Position?> getLocation() async {
    bool ok = await _handlePermission();
    if (!ok) return null;

    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      return null;
    }
  }
  Future<String?> getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(lat, lng);

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return "${place.locality}, ${place.country}";
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}
