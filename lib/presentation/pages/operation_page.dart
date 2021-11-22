import 'dart:async';

import 'package:container_locations/core/values/strings.dart';
import 'package:container_locations/cubit/operation/containers_cubit.dart';
import 'package:container_locations/cubit/operation/map_cubit.dart';
import 'package:container_locations/cubit/operation/marker_cubit.dart';
import 'package:container_locations/data/model/container_model.dart';
import 'package:container_locations/data/model/selected_container.dart';
import 'package:container_locations/data/model/selected_location.dart';
import 'package:container_locations/presentation/uicomponents/bottom_sheet.dart';
import 'package:container_locations/presentation/uicomponents/button.dart';
import 'package:container_locations/presentation/uicomponents/container_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';

class OperationPage extends StatelessWidget {
  const OperationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final _selectedContainer =
        Provider.of<SelectedContainer>(context, listen: false);
    final _selectedLocation =
        Provider.of<SelectedLocation>(context, listen: false);
    BlocProvider.of<ContainersCubit>(context).getLocations();

    return Scaffold(
      key: _scaffoldKey,
      body: MultiBlocListener(
        listeners: [
          BlocListener<MarkerCubit, MarkerState>(listener: (context, state) {
            if (state is MarkerTap) {
              BlocProvider.of<MapCubit>(context).reloadMarkersOnSelection(
                  state.container,
                  currentSelectedContainer:
                      _selectedContainer.currentSelectedContainer);
              _selectedContainer.setSelectedContainer(state.container);
              showCustomBottomSheet(
                  context: context,
                  scaffoldKey: _scaffoldKey,
                  content: containerInfo(context, state.container),
                  primaryButton: CustomButton(
                    label: StringResources.relocate,
                    onPress: () {
                      BlocProvider.of<ContainersCubit>(context)
                          .startRelocationProgress(state.container);
                    },
                  ),
                  secondaryButton: CustomButton(
                      label: StringResources.navigate,
                      onPress: () => _openMapsApp(state.container)));
            } else if (state is MarkerDetailError) {
              showCustomBottomSheet(
                  context: context,
                  scaffoldKey: _scaffoldKey,
                  isError: true,
                  autoDismiss: true,
                  content: Text(
                    StringResources.cannotLoadData,
                    style: Theme.of(context).textTheme.bodyText1,
                  ));
            }
          }),
          BlocListener<ContainersCubit, ContainersState>(
              listener: (context, state) {
            if (state is LocationRelocate) {
              showCustomBottomSheet(
                context: context,
                scaffoldKey: _scaffoldKey,
                closeOnDrag: false,
                content: Text(
                  StringResources.pleaseSelectLocation,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                primaryButton: CustomButton(
                  label: StringResources.save,
                  onPress: () {
                    BlocProvider.of<ContainersCubit>(context)
                        .changeContainerLocation(
                            id: _selectedContainer.selectedContainerId,
                            latLng: _selectedLocation.selectedLocation);
                  },
                ),
              );
            } else if (state is LocationRelocated) {
              _selectedContainer.setSelectedContainer(null);
              _selectedLocation.setSelectedLocation(null);
              showCustomBottomSheet(
                context: context,
                scaffoldKey: _scaffoldKey,
                autoDismiss: true,
                content: Text(
                  StringResources.relocatedSuccessfully,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              );
            } else if (state is Error) {
              showCustomBottomSheet(
                  context: context,
                  scaffoldKey: _scaffoldKey,
                  isError: true,
                  autoDismiss: true,
                  content: Text(
                    StringResources.cannotLoadData,
                    style: Theme.of(context).textTheme.bodyText1,
                  ));
            }
          })
        ],
        child: buildMap(),
      ),
    );
  }

  Widget buildMap() {
    Completer<GoogleMapController> _controller = Completer();
    return BlocConsumer<MapCubit, MapState>(
      listener: (context, state) {
        if (state is MapMarkers) {
          if (state.markers.isNotEmpty) {
            LatLng? selectedLoc =
                (Provider.of<SelectedContainer>(context, listen: false)
                            .currentSelectedContainer !=
                        null)
                    ? LatLng(
                        Provider.of<SelectedContainer>(context, listen: false)
                            .currentSelectedContainer!
                            .lat,
                        Provider.of<SelectedContainer>(context, listen: false)
                            .currentSelectedContainer!
                            .lng)
                    : null;
            _animateMapCamera(
                selectedLoc ?? state.markers.first.position, _controller);
          }
        }
      },
      builder: (context, state) {
        return GoogleMap(
          initialCameraPosition:
              const CameraPosition(target: LatLng(41, 28), zoom: 5),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: (state as MapMarkers).markers.toSet(),
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          onTap: (latLng) {
            if (state.mapTappable ?? false) {
              Provider.of<SelectedLocation>(context, listen: false)
                  .setSelectedLocation(latLng);
              BlocProvider.of<MapCubit>(context).addNewMarkerLocation(latLng);
            }
          },
        );
      },
    );
  }

  void _animateMapCamera(
      LatLng position, Completer<GoogleMapController> completer) async {
    final GoogleMapController controller = await completer.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 11)));
  }

  void _openMapsApp(ContainerModel container) {
    MapsLauncher.launchCoordinates(container.lat, container.lng);
  }
}
