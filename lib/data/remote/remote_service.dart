import 'package:container_locations/data/model/container_model.dart';
import 'package:container_locations/data/remote/constants/endpoints.dart';

import 'dio_client.dart';

class RemoteService {
  final DioClient _client;

  RemoteService(this._client);

  Future<List<ContainerModel>> getContainers() async {
    final res = await _client.get(Endpoints.getContainers) as List;
    return res.map((e) => ContainerModel.fromJson(e)).toList();
  }

  Future<void> updateContainer(int id, Map<String, dynamic> patchObj) async {
    await _client.patch(Endpoints.updateContainer(id), data: patchObj);
    return;
  }

  Future<ContainerModel> getContainer(int id) async {
    final res = await _client.get(Endpoints.getContainer(id));
    return ContainerModel.fromJson(res);
  }
}
