import 'package:maidenhead/maidenhead.dart';

// nice online tool: https://k7fry.com/grid/

void main(List<String> arguments) {
  print('Expecting:  [45.844271, 15.947917]');
  print(Maidenhead.to_location('JN75xu32SP')); // 45.844271  15.947917

  print('Expecting: [45.845313 15.946181]');
  print(Maidenhead.to_location('JN75XU32NV')); // 45.845313 15.946181

  print('Expecting: JN75xu32SP');
  print(Maidenhead.to_maiden(45.844271, 15.947917, 5));

  // https://www.google.com/maps/?api=1&map_action=map&center=45.844271,15.947917
  print(Maidenhead.google_maps_maiden('JN75xu32SP'));

  print('Distance 177.69963804384477 meters');
  print(Haversine.distance(45.844271, 15.947917, 45.845313, 15.946181)
      .toString());

  // 177.69963804384477 meters
  print(Haversine.distance_maiden('JN75xu32SP', 'JN75XU32NV'));

  var pos1 = Maidenhead.latlon(45.844271, 15.947917, precision: 5);
  var pos2 = Maidenhead.latlon(45.844271, 15.947917, precision: 5);
  var distance = pos1.distance_to(pos2);
  var bearing = pos1.bearing_to(pos2);
  print('distance: ' + distance.toString() + ' bearing: ' + bearing.toString());
  print('pos1 to pos2 distance: ' +
      Haversine.distance_maiden(pos1.grid, pos2.grid).toString());

  print(
      'https://www.igismap.com/formula-to-find-bearing-or-heading-angle-between-two-points-latitude-longitude/');
  print(
      'K. City 39.099912, -94.581213 St. Louis 38.627089, -90.200203   96.51°');
  pos1 = Maidenhead.latlon(39.099912, -94.581213, precision: 5); // Kansas City
  pos2 = Maidenhead.latlon(38.627089, -90.200203, precision: 5); // St. Louis
  distance = pos1.distance_to(pos2);
  bearing = pos1.bearing_to(pos2);
  print('distance: ' +
      distance.toString() +
      ' bearing K. City -> St. Louis: ' +
      bearing.toString());
}
