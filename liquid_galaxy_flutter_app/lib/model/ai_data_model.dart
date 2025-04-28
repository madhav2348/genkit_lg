class AIDataModel {
  final String place;
  final String description;
  final List<String> intrestingFact;
  final Location latlog;

  AIDataModel({
    required this.place,
    required this.description,
    required this.intrestingFact,
    required this.latlog,
  });

  factory AIDataModel.fromJson(Map<String, dynamic> data) {
    return AIDataModel(
      place: data['place'],
      description: data['description'],
      intrestingFact:
          (data['interesting_facts'] as List<dynamic>)
              .map((element) => element.toString())
              .toList(),
      latlog: Location.fromJson(data['coordinates'] as Map<String, dynamic>),
    );
  }
}

class Location {
  final String latitude;
  final String longitute;

  Location({required this.latitude, required this.longitute});

  factory Location.fromJson(Map<String, dynamic> data) {
    return Location(latitude: data["latitude"], longitute: data["longitude"]);
  }

  String get flyToLocation {
    return '<LookAt><longitude>$longitute</longitude><latitude>$latitude</latitude><heading>0</heading><tilt>0</tilt><range>2400</range></LookAt>';
  }
}
