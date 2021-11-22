import 'package:bloc/bloc.dart';
import 'package:container_locations/core/di/injector.dart';
import 'package:container_locations/cubit/operation/map_cubit.dart';
import 'package:container_locations/data/model/container_model.dart';
import 'package:container_locations/data/remote/repository/container_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'containers_state.dart';

class ContainersCubit extends Cubit<ContainersState> {
  final MapCubit _mapCubit = getIt<MapCubit>();
  final ContainerRepository _repository = getIt<ContainerRepository>();

  ContainersCubit() : super(OperationInitial());

  Future<void> getLocations() async {
    emit(LocationsLoading());
    _repository
        .fetchContainers()
        .catchError((_) => emit(Error()))
        .then((value) async {
      await _mapCubit.customIcon();
      _mapCubit.loadMarkers(_createMarkerList(value));
      emit(LocationsLoaded());
    });
  }

  void startRelocationProgress(ContainerModel item) {
    List<ContainerModel> containers = List.empty(growable: true);
    containers.add(item);
    _mapCubit.loadMarkers(_createMarkerList(containers, tappable: false));
    _mapCubit.enableMapOnTapEvent();
    emit(LocationRelocate());
  }

  Future<void> changeContainerLocation({int? id, LatLng? latLng}) async {
    if (id != null && latLng != null) {
      await _repository
          .updateContainerLocation(id, latLng)
          .then((_) => emit(LocationRelocated()))
          .catchError((_) => emit(Error()));
    }

    getLocations();
  }

  List<Marker> _createMarkerList(List<ContainerModel> containers,
      {bool tappable = true}) {
    return containers
        .map((e) => _mapCubit.createMarker(e, tappable: tappable))
        .toList();
  }
}
