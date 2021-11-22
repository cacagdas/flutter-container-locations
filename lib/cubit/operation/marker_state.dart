part of 'marker_cubit.dart';

@immutable
abstract class MarkerState {}

class MarkerInitial extends MarkerState {}

class MarkerTap extends MarkerState {
  final ContainerModel container;
  MarkerTap(this.container);
}

class MarkerDetailError extends MarkerState {}
