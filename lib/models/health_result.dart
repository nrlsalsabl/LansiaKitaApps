class HealthResult {
  final int heartRate;
  final double spo2;
  final double temperature;
  final String status;
  final bool isAnomaly;
  final double latitude;
  final double longitude;
  final int batteryLevel;

  const HealthResult({
    required this.heartRate,
    required this.spo2,
    required this.temperature,
    required this.status,
    required this.isAnomaly,
    required this.latitude,
    required this.longitude,
    required this.batteryLevel,
  });

  Map<String, dynamic> toJson() {
    return {
      "deviceId": "XIAOMI_DEMO_001",
      "heartRate": heartRate,
      "spo2": spo2,
      "temperature": temperature,
      "status": status,
      "isAnomaly": isAnomaly,
      "latitude": latitude,
      "longitude": longitude,
      "source": "HEALTH_CONNECT",
      "batteryLevel": batteryLevel,
    };
  }
}