A maidenhead library for HAM radio operators. Converting lat/lon to maidenhead locator
and vice versa,...

[license](https://raw.githubusercontent.com/goranskular/maidenhead/master/LICENSE).

## Usage

A simple usage example:

```dart
import 'package:maidenhead/maidenhead.dart';

void main(List<String> arguments) {
  print(Maidenhead.to_location('JN75xu32SP')); // 45.844271  15.947917
  print(Maidenhead.to_location('JN75XU32NV')); // 45.845313 15.946181
  print(Maidenhead.to_maiden(45.844271, 15.947917, 5));
  print(Maidenhead.google_maps_maiden('JN75xu32SP'));

    // 177.69963804384477 meters
  print(Haversine.distance_maiden('JN75xu32SP', 'JN75XU32NV'));

  var pos1 = Maidenhead.latlon(45.844271, 15.947917, precision: 5);
  var pos2 = Maidenhead.latlon(45.844271, 15.947917, precision: 5);
  var distance = pos1.distance_to(pos2);
  var bearing = pos1.bearing_to(pos2);
  print('distance: ' + distance.toString() + ' bearing: ' + bearing.toString());
  print('pos1 to pos2 distance: ' +
      Haversine.distance_maiden(pos1.grid, pos2.grid).toString());
}
```

## Github

Please file feature requests and bugs at the [github](https://github.com/goranskular/maidenhead.git)

## pub.dev

[pub.dev](https://pub.dev/packages/maidenhead)

73 de 9A1GS (former 9A3GOS)