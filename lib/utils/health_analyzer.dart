import '../models/health_status.dart';

enum HealthCondition {
  green,
  yellow,
  red,
}

class HealthAnalyzer {
  static HealthStatus analyze({
    int? heartRate,
    double? spo2,
    int? steps,
    double? sleep,
  }) {
    int score = 100;
    List<String> reasons = [];

    // ===========================
    // HEART RATE
    // ===========================
    if (heartRate != null) {
      if (heartRate < 50 || heartRate > 120) {
        score -= 40;
        reasons.add("Heart Rate tidak normal");
      } else if (heartRate < 60 || heartRate > 100) {
        score -= 20;
        reasons.add("Heart Rate perlu dipantau");
      } else {
        reasons.add("Heart Rate normal");
      }
    }

    // ===========================
    // SPO2
    // ===========================
    if (spo2 != null) {
      if (spo2 < 90) {
        score -= 40;
        reasons.add("SpO₂ rendah");
      } else if (spo2 < 95) {
        score -= 20;
        reasons.add("SpO₂ perlu dipantau");
      } else {
        reasons.add("SpO₂ normal");
      }
    }

    // ===========================
    // STEPS
    // ===========================
    if (steps != null) {
      if (steps < 2000) {
        score -= 10;
        reasons.add("Aktivitas rendah");
      } else {
        reasons.add("Aktivitas cukup");
      }
    }

    // ===========================
    // SLEEP
    // ===========================
    if (sleep != null) {
      if (sleep < 5) {
        score -= 10;
        reasons.add("Kurang tidur");
      } else {
        reasons.add("Tidur cukup");
      }
    }

    if (score < 0) score = 0;

    String status;
    int syncInterval;

    if (score >= 80) {
      status = "Normal";
      syncInterval = 300;
    } else if (score >= 50) {
      status = "Warning";
      syncInterval = 60;
    } else {
      status = "Danger";
      syncInterval = 30;
    }

    return HealthStatus(
      heartRate: heartRate,
      spo2: spo2,
      steps: steps,
      sleep: sleep,
      status: status,
      score: score,
      reasons: reasons,
      syncInterval: syncInterval,
      lastSync: DateTime.now(),
    );
  }
}