import 'package:container_locations/data/model/container_model.dart';
import 'package:container_locations/data/remote/remote_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ContainerRepository {
  final RemoteService _service;
  ContainerRepository(this._service);

  Future<List<ContainerModel>> fetchContainers() async =>
      await _service.getContainers();

  Future<void> updateContainerLocation(int id, LatLng latLng) async {
    final patchObj = {"lat": latLng.latitude, "lng": latLng.longitude};
    return await _service.updateContainer(id, patchObj);
  }

  Future<ContainerModel> getContainerDetail(int id) async =>
      await _service.getContainer(id);
}
