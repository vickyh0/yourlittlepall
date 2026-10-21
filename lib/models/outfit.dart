/// A set of clothes that includes a top and a bottom piece.
class Outfit {
  /// The item worn on the top half of the body.
  /// Defaults to an empty string.
  final String top;

  /// The item worn on the bottom half of the body.
  /// Defaults to an empty string.
  final String bottom;

  /// Creates a set of clothes.
  /// Parameters:
  /// - String top: The name or description of the top item.
  /// - String bottom: The name or description of the bottom item.
  const Outfit({this.top = '', this.bottom = ''});

  /// Makes a copy of this outfit with new choices for the top or bottom.
  /// Parameters:
  /// - String? top: The optional new top item to use instead of the current one.
  /// - String? bottom: The optional new bottom item to use instead of the current one.
  /// Returns: A new Outfit object containing the updated clothing pieces.
  Outfit update({String? top, String? bottom}) {
    return Outfit(top: top ?? this.top, bottom: bottom ?? this.bottom);
  }

  /// Converts this outfit into a map format that works with JSON.
  /// Returns: A Map with String keys holding the clothes data.
  Map<String, dynamic> toJson() => <String, dynamic>{
    'top': top,
    'bottom': bottom,
  };

  /// Creates an outfit using data from a JSON map.
  /// Parameters:
  /// - Map String, dynamic> json: The data map containing the clothes information.
  /// Returns: A new Outfit matching the text found in the map data.
  factory Outfit.fromJson(Map<String, dynamic> json) =>
      Outfit(top: json['top'] as String, bottom: json['bottom'] as String);
}
