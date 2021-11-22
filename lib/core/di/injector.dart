import 'package:dio/dio.dart';
import 'package:container_locations/cubit/login/login_cubit.dart';
import 'package:container_locations/cubit/operation/containers_cubit.dart';
import 'package:container_locations/cubit/operation/map_cubit.dart';
import 'package:container_locations/cubit/operation/marker_cubit.dart';
import 'package:container_locations/data/remote/dio_client.dart';
import 'package:container_locations/data/remote/remote_service.dart';
import 'package:container_locations/data/remote/repository/container_repository.dart';
import 'package:get_it/get_it.dart';

import 'module/network_module.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupInjection() async {
  getIt.registerSingleton<Dio>(NetworkModule.provideDio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(RemoteService(getIt<DioClient>()));
  getIt.registerSingleton(ContainerRepository(getIt<RemoteService>()));

  getIt.registerSingleton(LoginCubit());
  getIt.registerSingleton(MarkerCubit());
  getIt.registerSingleton(MapCubit());
  getIt.registerSingleton(ContainersCubit());
}
