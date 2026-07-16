class HealthStatus {
  final int? heartRate;
  final int? steps;
  final double? spo2;
  final double? sleep;

  final String status;

  /// Health Score (0-100)
  final int score;

  /// Alasan status
  final List<String> reasons;

  /// Interval sync (detik)
  final int syncInterval;

  final DateTime lastSync;

  const HealthStatus({
    this.heartRate,
    this.steps,
    this.spo2,
    this.sleep,
    this.status = "Unknown",
    this.score = 0,
    this.reasons = const [],
    this.syncInterval = 300,
    required this.lastSync,
  });

  HealthStatus copyWith({
    int? heartRate,
    int? steps,
    double? spo2,
    double? sleep,
    String? status,
    int? score,
    List<String>? reasons,
    int? syncInterval,
    DateTime? lastSync,
  }) {
    return HealthStatus(
      heartRate: heartRate ?? this.heartRate,
      steps: steps ?? this.steps,
      spo2: spo2 ?? this.spo2,
      sleep: sleep ?? this.sleep,
      status: status ?? this.status,
      score: score ?? this.score,
      reasons: reasons ?? this.reasons,
      syncInterval: syncInterval ?? this.syncInterval,
      lastSync: lastSync ?? this.lastSync,
      
    );
  }
}