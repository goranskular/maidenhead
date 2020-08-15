import 'package:maidenhead/maidenhead.dart';

// nice online tool: https://k7fry.com/grid/

void main(List<String> arguments) {
  print(Maidenhead.to_location('JN75xu32SP')); // 45.844271  15.947917
  print(Maidenhead.to_location('JN75XU32NV')); // 45.845313 15.946181
  print(Maidenhead.to_maiden(45.844271, 15.947917, 5));
  print(Maidenhead.google_maps_maiden('JN75xu32SP'));
}
