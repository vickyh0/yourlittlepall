import 'package:flutter/foundation.dart';
import 'package:yourlittlepal/providers/weather_provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yourlittlepal/weather_conditions.dart';

/// The [WeatherChecker] is responsible for fetching real-time weather data
/// from the National Weather Service API and updating the [WeatherProvider].
class WeatherChecker {
  final WeatherProvider weatherProvider;
  double _latitude = 0;
  double _longitude = 0;

  /// Optional client for dependency injection (useful for testing).
  http.Client? client;

  WeatherChecker(this.weatherProvider, {this.client});

  /// Updates the internal coordinates used for the weather query.
  void updateLocation(double latitude, double longitude) {
    _longitude = longitude;
    _latitude = latitude;
  }

  /// Fetches weather data in two steps:
  /// 1. Maps coordinates to a grid endpoint.
  /// 2. Retrieves the forecast from that grid endpoint.
  Future<void> fetchAndUpdateCurrentWeather() async {
    // Use the provided client or instantiate a new one.
    final http.Client client = this.client ?? http.Client();

    try {
      // Step 1: Get grid points for coordinates.
      final gridResponse = await client.get(
        Uri.parse('https://api.weather.gov/points/$_latitude,$_longitude'),
      );

      final gridParsed = (jsonDecode(gridResponse.body));
      final String? forecastURL = gridParsed['properties']?['forecast'];

      if (forecastURL != null) {
        // Step 2: Get forecast from the retrieved URL.
        final weatherResponse = await client.get(Uri.parse(forecastURL));
        final weatherParsed = jsonDecode(weatherResponse.body);

        // Extract the first period (current forecast).
        final currentPeriod = weatherParsed['properties']?['periods']?[0];

        if (currentPeriod != null) {
          final temperature = currentPeriod['temperature'];
          final shortForecast = currentPeriod['shortForecast'];

          if (kDebugMode) {
            print(
              'Weather updated at ${DateTime.now()}: $temperature°F, $shortForecast',
            );
          }

          if (temperature != null && shortForecast != null) {
            final condition = _shortForecastToCondition(shortForecast);
            weatherProvider.updateWeather(temperature, condition);
          }
        }
      }
    } catch (e) {
      // Fallback update on failure.
      if (kDebugMode) print('Error fetching weather: $e');
      weatherProvider.updateData();
    } finally {
      // Cleanup client instance.
      if (this.client == null) client.close();
    }
  }

  /// Maps NWS short forecast strings to the local [WeatherCondition] enum.
  WeatherCondition _shortForecastToCondition(String shortForecast) {
    final lowercased = shortForecast.toLowerCase();

    if (lowercased.contains('rain')) return WeatherCondition.rainy;
    if (lowercased.contains('sun') ||
        lowercased.contains('clear') ||
        lowercased.contains('partly')) {
      return WeatherCondition.sunny;
    }
    return WeatherCondition.gloomy;
  }
}
