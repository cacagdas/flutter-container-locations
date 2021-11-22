class ContainerModel {
  int id;
  int sensorId;
  int occupancy;
  int temperature;
  int date;
  double lat;
  double lng;

  ContainerModel(
      {required this.id,
      required this.sensorId,
      required this.occupancy,
      required this.temperature,
      required this.date,
      required this.lat,
      required this.lng});

  ContainerModel.fromJson(Map json)
      : id = json["id"],
        sensorId = json["sensorId"],
        occupancy = json["occupancy"],
        temperature = json["temperature"],
        date = json["date"],
        lat = json["lat"],
        lng = json["lng"];
}
