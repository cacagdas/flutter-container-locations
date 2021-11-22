part of 'map_cubit.dart';

@immutable
abstract class MapState {}

class MapMarkers extends MapState {
  final List<Marker> markers;
  final bool? mapTappable;
  MapMarkers(this.markers, {this.mapTappable = false});
}
