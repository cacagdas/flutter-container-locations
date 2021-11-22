import 'package:bloc/bloc.dart';
import 'package:container_locations/core/di/injector.dart';
import 'package:container_locations/core/util/asset_util.dart';
import 'package:container_locations/data/model/container_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import 'marker_cubit.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final MarkerCubit _markerCubit = getIt<MarkerCubit>();
  BitmapDescriptor defaultMarkerIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor selectedMarkerIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);

  MapCubit() : super(MapMarkers(List.empty()));

  List<Marker> markerInfo = List.empty();

  loadMarkers(List<Marker> markers, {bool? tappable = false}) {
    markerInfo = markers;
    emit(MapMarkers(markers, mapTappable: tappable));
  }

  Future<void> addNewMarkerLocation(LatLng latLng) async {
    await customIcon();
    if (markerInfo.length > 1) {
      markerInfo.removeLast();
    }
    markerInfo.add(Marker(
        markerId: MarkerId(DateTime.now().toString()),
        position: LatLng(latLng.latitude, latLng.longitude),
        onTap: () {},
        icon: selectedMarkerIcon));
    loadMarkers(markerInfo, tappable: true);
  }

  // TODO the implementation of changing marker icon should be considered
  reloadMarkersOnSelection(ContainerModel container,
      {ContainerModel? currentSelectedContainer}) {
    if (currentSelectedContainer != null) {
      _removeAndReAdd(currentSelectedContainer, false);
    }
    _removeAndReAdd(container, true);
    loadMarkers(markerInfo);
  }

  _removeAndReAdd(ContainerModel container, bool selected) {
    markerInfo.removeAt(markerInfo.indexWhere(
        (element) => element.markerId.value == container.id.toString()));
    markerInfo.add(createMarker(container, selected: selected));
  }

  Marker createMarker(ContainerModel e,
      {bool tappable = true, bool selected = false}) {
    return Marker(
        markerId: MarkerId(e.id.toString()),
        position: LatLng(e.lat, e.lng),
        onTap: () {
          if (tappable) {
            _markerCubit.onMarkerTap(e);
          }
        },
        icon: selected ? selectedMarkerIcon : defaultMarkerIcon);
  }

  customIcon() async {
    await getBytesFromAsset('assets/ic_marker_green.png', 120).then((value) {
      defaultMarkerIcon = BitmapDescriptor.fromBytes(value);
    });
    await getBytesFromAsset('assets/ic_marker_yellow.png', 120).then((value) {
      selectedMarkerIcon = BitmapDescriptor.fromBytes(value);
    });
  }

  enableMapOnTapEvent() => emit(MapMarkers(markerInfo, mapTappable: true));
}
