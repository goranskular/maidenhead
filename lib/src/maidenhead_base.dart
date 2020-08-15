class Maidenhead {
  /// Latitude and Longitude stored in a double
  double lat, lon;

  /// Maidenead locator grid string
  String grid;

  /// Initialize from latlong and calculate maidenhead grid
  Maidenhead.latlon(double lat, double lon) {
    this.lat = lat;
    this.lon = lon;
    grid = to_maiden(lat, lon);
  }

  /// Initialize from grid and calculate lat and long
  Maidenhead.grid(String grid) {
    this.grid = grid;
    var latlon = to_location(grid);
    lat = latlon[0];
    lon = latlon[1];
  }

  /// Convert latitude and longitude to the maidenhead grid locator
  /// default most used precision is 3
  /// Precision 5 is very accurate
  static String to_maiden(double lat, double lon, [int precision = 3]) {
    //
    var nA = 'A'.codeUnits.first;
    var lon_div = ((lon + 180) / 20).floor().toDouble();
    var lon_remainder = ((lon + 180) % 20).toDouble();
    var lat_div = ((lat + 90) / 10).floor().toDouble();
    var lat_remainder = ((lat + 90) % 10).toDouble();
    // first pair
    var maiden = String.fromCharCode(nA + lon_div.round()) +
        String.fromCharCode(nA + lat_div.round());

    lat = lat_remainder;
    lon = lon_remainder / 2.0;

    var i = 1;
    // for every precision level we use one additional pair
    // first char in a pair presents lon, second lat
    while (i < precision) {
      i++;
      lon_div = lon.floor().toDouble();
      lon_remainder = (lon % 1).toDouble();
      lat_div = lat.floor().toDouble();
      lat_remainder = (lat % 1).toDouble();

      if ((i % 2 == 0)) {
        maiden += lon_div.round().toString() + lat_div.round().toString();
        lon = 24 * lon_remainder;
        lat = 24 * lat_remainder;
      } else {
        maiden += String.fromCharCode(nA + lon_div.round()) +
            String.fromCharCode(nA + lat_div.round());
        lon = 10 * lon_remainder;
        lat = 10 * lat_remainder;
      }

      // third pair is normally lowercase (e.g. 'JN75xu32SP')
      // we need to use toLowerCase
      if (maiden.length >= 6) {
        maiden = maiden.substring(0, 4) +
            maiden.substring(4, 6).toLowerCase() +
            maiden.substring(6);
      }
    }
    return maiden;
  }

  /// Convert maidenhead grid to the latitude and longitude
  /// Lat/Long with 6 decimal places
  static List<double> to_location(String grid) {
    // length is precision level * 2
    // if it is a standard most used precision 3 locator
    // length will be 6  (e.g. 'JN75xu')
    var lN = grid.length;
    var nA = 'A'.codeUnits.first;
    var lon = -180.0;
    var lat = -90.0;
    // we first need to convert to upper case
    var maiden = grid.toUpperCase();
    // extract first pair
    lon += (maiden[0].codeUnits.first - nA) * 20;
    lat += (maiden[1].codeUnits.first - nA) * 10;

    // second pair
    if (lN >= 4) {
      lon += int.parse(maiden[2]) * 2;
      lat += int.parse(maiden[3]) * 1;
    }

    // third pair (precision 3)
    if (lN >= 6) {
      lon += ((maiden[4].codeUnits.first - nA) * 5.0 / 60);
      lat += ((maiden[5].codeUnits.first - nA) * 2.5 / 60);
    }

    // fourth pair (precision 4)
    if (lN >= 8) {
      lon += int.parse(grid[6]) * 5.0 / 600;
      lat += int.parse(grid[7]) * 2.5 / 600;
    }

    // fifth pair (precision 5)
    if (lN >= 10) {
      lon += ((maiden[8].codeUnits.first - nA) / 2880);
      lat += ((maiden[9].codeUnits.first - nA) / 5760);
    }

    // truncate to 6 decimal places
    lat = num.parse(lat.toStringAsFixed(6));
    lon = num.parse(lon.toStringAsFixed(6));

    return List<double>.unmodifiable([lat, lon]);
  }

  /// Maidenhead grid to google maps url
  static String google_maps_maiden(String grid) {
    var latlon = to_location(grid);
    return 'https://www.google.com/maps/?api=1&map_action=map&center=' +
        latlon[0].toString() +
        ',' +
        latlon[1].toString();
  }
}
