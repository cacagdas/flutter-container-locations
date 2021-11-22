class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl =
      "FIREBASE_RTDB_URL";
  static const String getContainers = "/containers.json";
  static String updateContainer(int id) => "/containers/${id.toString()}.json";
  static String getContainer(int id) => "/containers/${id.toString()}.json";
}
