import 'package:container_locations/cubit/login/login_cubit.dart';
import 'package:container_locations/cubit/operation/containers_cubit.dart';
import 'package:container_locations/cubit/operation/map_cubit.dart';
import 'package:container_locations/cubit/operation/marker_cubit.dart';
import 'package:container_locations/data/model/selected_container.dart';
import 'package:container_locations/data/model/selected_location.dart';
import 'package:container_locations/presentation/pages/login_page.dart';
import 'package:container_locations/presentation/pages/operation_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'di/injector.dart';

extension NavigatorExt on BuildContext {
  void navigateToOperationPage() {
    Navigator.pushReplacement(
        this,
        CupertinoPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => getIt<ContainersCubit>(),
                    ),
                    BlocProvider(
                      create: (context) => getIt<MarkerCubit>(),
                    ),
                    BlocProvider(
                      create: (context) => getIt<MapCubit>(),
                    ),
                  ],
                  child: MultiProvider(providers: [
                    Provider(create: (context) => SelectedContainer()),
                    Provider(create: (context) => SelectedLocation()),
                  ], child: const OperationPage()),
                )));
  }

  void navigateToLoginPage() {
    Navigator.pushReplacement(
        this,
        CupertinoPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<LoginCubit>(),
                  child: const LoginPage(),
                )));
  }
}
