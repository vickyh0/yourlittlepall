/// Represents the weather categories supported by the application.
///
/// Used by the [WeatherProvider] to adapt pet interactions
/// and UI elements based on the current environment.
enum WeatherCondition {
  /// Weather state could not be determined.
  unknown,

  /// Overcast, cloudy, or otherwise indistinct weather.
  gloomy,

  /// Clear or sunny conditions.
  sunny,

  /// Precipitation is occurring.
  rainy,
}
