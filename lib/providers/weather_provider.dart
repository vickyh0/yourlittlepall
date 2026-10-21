//from as5 foodfinder weather_provider.dart

import 'package:flutter/material.dart';
import 'package:yourlittlepal/weather_conditions.dart';
import 'package:yourlittlepal/weather_checker.dart';
import 'dart:async';

/// A data provider that fetches, updates, and tracks local weather records.
class WeatherProvider extends ChangeNotifier {
  /// The current outdoor temperature value tracked in Fahrenheit.
  int tempInFahrenheit = 0;

  /// The active general weather type matching current atmosphere trends.
  WeatherCondition condition = WeatherCondition.unknown;

  /// The worker class engine module that communicates with backend weather networks.
  late WeatherChecker _checker;

  /// Whether the current weather tracking dataset is parsed and valid to read.
  bool isValid = false;

  /// Whether a network lookup or data processing mistake happened during a fetch attempt.
  bool error = false;

  /// Creates a weather monitoring instance and sets up a recurring network refresh loop.
  /// Parameters: None.
  /// Returns: A WeatherProvider object that connects background fetch calls to app view layers.
  WeatherProvider() {
    _checker = WeatherChecker(this);
    _checker.fetchAndUpdateCurrentWeather();
    //ignore: unused_local_variable
    final Timer weatherCheckerTime = Timer.periodic(
      const Duration(seconds: 60),
      (_) => _checker.fetchAndUpdateCurrentWeather(),
    );
  }

  /// Refreshes the local tracking metrics using newly processed atmospheric records.
  /// Parameters:
  /// - int newTempFahrenheit: The newly updated raw temperature reading value.
  /// - WeatherCondition newCondition: The updated categorical weather state choice.
  void updateWeather(int newTempFahrenheit, WeatherCondition newCondition) {
    isValid = true;
    error = false;
    tempInFahrenheit = newTempFahrenheit;
    condition = newCondition;
    notifyListeners();
  }

  /// Relocates the weather collection target coordinates and forces an immediate data pull sequence.
  /// Parameters:
  /// - double latitude: The new north-south geographic lookup metric.
  /// - double longitude: The new east-west geographic lookup metric.
  void updateLocation(double latitude, double longitude) {
    _checker.updateLocation(latitude, longitude);
    _checker.fetchAndUpdateCurrentWeather();
  }

  /// Sets the internal flag states to signal that an atmospheric data fetch step failed.
  void updateData() {
    error = true;
    notifyListeners();
  }
}
