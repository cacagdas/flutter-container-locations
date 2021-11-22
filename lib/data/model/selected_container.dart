import 'package:container_locations/data/model/container_model.dart';

class SelectedContainer {
  ContainerModel? selectedContainer;

  SelectedContainer({this.selectedContainer});

  ContainerModel? get currentSelectedContainer {
    return selectedContainer;
  }

  int? get selectedContainerId {
    return selectedContainer?.id;
  }

  void setSelectedContainer(ContainerModel? container) {
    selectedContainer = container;
  }
}
