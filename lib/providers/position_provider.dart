//from as5 foodfinder position_provider.dart

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';

/// A location provider that tracks and updates the geographic coordinates of the device.
class PositionProvider extends ChangeNotifier {
  /// The most recent north-south coordinate value recorded from the device hardware.
  double? latitude;

  /// The most recent east-west coordinate value recorded from the device hardware.
  double? longitude;

  /// Checks if both coordinate components contain active numerical tracking data.
  /// Returns: A boolean stating true if the location readings are valid and loaded.
  bool get positionKnown => latitude != null && longitude != null;

  /// Creates a location tracker instance and sets up a recurring interval loop.
  /// Parameters: None.
  /// Returns: A PositionProvider object that begins immediate location requests.
  PositionProvider() {
    _determinePosition().then((s) {
      latitude = s.latitude;
      longitude = s.longitude;
      notifyListeners();
    });
    //ignore: unused_local_variable
    final Timer positionProviderTime = Timer.periodic(
      const Duration(seconds: 1),
      (s) => _determinePosition().then((a) {
        latitude = a.latitude;
        longitude = a.longitude;
        notifyListeners();
      }),
    );
  }

  /// Verifies active OS background services and permission parameters to pull raw coordinate values.
  /// Parameters: None.
  /// Returns: A Future that completes with the current tracking hardware position data.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }
}
