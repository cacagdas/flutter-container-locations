import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectedLocation {
  LatLng? selectedLatLng;

  SelectedLocation({this.selectedLatLng});

  LatLng? get selectedLocation {
    return selectedLatLng;
  }

  void setSelectedLocation(LatLng? latLng) {
    selectedLatLng = latLng;
  }
}
