class Telemetry {
  final String id;
  final String deviceId;
  final String lansiaId;
  final int heartRate;
  final double spo2;
  final double temperature;
  final double latitude;
  final double longitude;
  final String status;
  final String source;
  final bool isAnomaly;
  final DateTime timestamp;

  const Telemetry({
    required this.id,
    required this.deviceId,
    required this.lansiaId,
    required this.heartRate,
    required this.spo2,
    required this.temperature,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.source,
    required this.isAnomaly,
    required this.timestamp,
  });

  factory Telemetry.fromJson(Map<String, dynamic> json) {
    return Telemetry(
      id: json["id"],
      deviceId: json["deviceId"],
      lansiaId: json["lansiaId"],
      heartRate: json["heartRate"],
      spo2: (json["spo2"] as num).toDouble(),
      temperature: (json["temperature"] as num).toDouble(),
      latitude: (json["latitude"] as num).toDouble(),
      longitude: (json["longitude"] as num).toDouble(),
      status: json["status"],
      source: json["source"],
      isAnomaly: json["isAnomaly"],
      timestamp: DateTime.parse(json["timestamp"]),
    );
  }
}