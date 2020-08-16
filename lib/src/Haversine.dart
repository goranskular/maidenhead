import 'package:maidenhead/maidenhead.dart';
import 'dart:math' as math;

class Haversine {
  const Haversine();

  /// Calculates distance with Haversine algorithm.
  ///
  /// Accuracy can be out by 0.3%
  /// More on [Wikipedia](https://en.wikipedia.org/wiki/Haversine_formula)
  /// Original in https://github.com/MikeMitterer/dart-latlong/tree/master/lib/latlong/calculator
  static double distance(final double lat1, final double lon1,
      final double lat2, final double lon2) {
    final sinDLat = math.sin((degToRadian(lat2) - degToRadian(lat1)) / 2);
    final sinDLng = math.sin((degToRadian(lon2) - degToRadian(lon1)) / 2);

    // Sides
    final a = sinDLat * sinDLat +
        sinDLng *
            sinDLng *
            math.cos(degToRadian(lat1)) *
            math.cos(degToRadian(lat2));
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return EQUATOR_RADIUS * c;
  }

  static double distance_maiden(String grid_p1, String grid_p2) {
    var p1 = Maidenhead.to_location(grid_p1);
    var p2 = Maidenhead.to_location(grid_p2);
    return distance(p1[0], p1[1], p2[0], p2[1]);
  }
}
