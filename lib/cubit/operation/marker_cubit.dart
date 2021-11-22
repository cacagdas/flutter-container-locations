import 'package:bloc/bloc.dart';
import 'package:container_locations/core/di/injector.dart';
import 'package:container_locations/data/model/container_model.dart';
import 'package:container_locations/data/remote/repository/container_repository.dart';
import 'package:meta/meta.dart';

part 'marker_state.dart';

class MarkerCubit extends Cubit<MarkerState> {
  final ContainerRepository _repository = getIt<ContainerRepository>();

  MarkerCubit() : super(MarkerInitial());

  onMarkerTap(ContainerModel container) {
    _repository
        .getContainerDetail(container.id)
        .then((value) => emit(MarkerTap(container)))
        .catchError((_) => emit(MarkerDetailError()));
  }
}
