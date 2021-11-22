part of 'containers_cubit.dart';

@immutable
abstract class ContainersState {}

class OperationInitial extends ContainersState {}

class LocationsLoading extends ContainersState {}

class Error extends ContainersState {}

class LocationsLoaded extends ContainersState {}

class LocationRelocate extends ContainersState {}

class LocationRelocated extends ContainersState {}
