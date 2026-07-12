class HealthResult {
  final String status;
  final int score;
  final List<String> reasons;
  final bool anomaly;
  final int syncInterval; // detik

  const HealthResult({
    required this.status,
    required this.score,
    required this.reasons,
    required this.anomaly,
    required this.syncInterval,
  });
}
