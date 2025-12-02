class Activity {
  String id;
  String imagePath;
  double lat;
  double lng;
  String time;

  Activity({
    required this.id,
    required this.imagePath,
    required this.lat,
    required this.lng,
    required this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "imagePath": imagePath,
      "lat": lat,
      "lng": lng,
      "time": time,
    };
  }

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'] ?? '',
      imagePath: json['imagePath'] ?? '',
      lat: (json['lat'] ?? 0).toDouble(),
      lng: (json['lng'] ?? 0).toDouble(),
      time: json['time'] ?? '',
    );
  }
}
