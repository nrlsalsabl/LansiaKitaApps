import 'package:health/health.dart';

class HealthService {
  final Health health = Health();

  Future<void> init() async {
    await health.configure();
  }

  Future<bool> checkHealthConnect() async {
    return await health.isHealthConnectAvailable();
  }

  Future<void> debug() async {
    await health.configure();

    final status = await health.getHealthConnectSdkStatus();
    // ignore: avoid_print
    print("STATUS = $status");

    final available = await health.isHealthConnectAvailable();
    print("AVAILABLE = $available");
  }

  Future<bool> requestPermission() async {
    try {
      final granted = await health.requestAuthorization(
        [HealthDataType.HEART_RATE, HealthDataType.BLOOD_OXYGEN],
        permissions: [HealthDataAccess.READ, HealthDataAccess.READ],
      );

      print("Permission result = $granted");

      return granted;
    } catch (e, s) {
      print("ERROR = $e");
      print(s);
      return false;
    }
  }

  Future<int?> getHeartRate() async {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));

    final data = await health.getHealthDataFromTypes(
      startTime: yesterday,
      endTime: now,
      types: [HealthDataType.HEART_RATE],
    );

    if (data.isEmpty) return null;

    final text = data.last.value.toString();

    final bpm = int.tryParse(RegExp(r'(\d+)').firstMatch(text)?.group(1) ?? '');

    return bpm;
  }

  Future<double?> getSpo2() async {
    final now = DateTime.now();

    final yesterday = now.subtract(const Duration(days: 7));

    final data = await health.getHealthDataFromTypes(
      startTime: yesterday,
      endTime: now,
      types: [HealthDataType.BLOOD_OXYGEN],
    );

    if (data.isEmpty) {
      return null;
    }

    final value = data.last.value;

    if (value is NumericHealthValue) {
      return value.numericValue.toDouble();
    }

    return null;
  }

  Future<int?> getSteps() async {
    final now = DateTime.now();
    final yesterday = now.subtract(Duration(days: 1));

    final steps = await health.getTotalStepsInInterval(yesterday, now);

    return steps;
  }

  Future<double?> getSleep() async {
    final now = DateTime.now();
    final yesterday = now.subtract(Duration(days: 1));

    final data = await health.getHealthDataFromTypes(
      startTime: yesterday,
      endTime: now,
      types: [HealthDataType.SLEEP_SESSION],
    );

    if (data.isEmpty) return null;

    double totalHours = 0;

    for (var item in data) {
      totalHours += item.dateTo.difference(item.dateFrom).inMinutes / 60;
    }

    return totalHours;
  }
}
