import 'package:flutter/material.dart';

import '../models/health_status.dart';
import '../services/health_services.dart';
import '../utils/health_analyzer.dart';
import '../managers/adaptive_sync_manager.dart';

class HealthProvider extends ChangeNotifier {
  final HealthService _service = HealthService();
  final AdaptiveSyncManager _syncManager = AdaptiveSyncManager();

  HealthStatus healthStatus = HealthStatus(lastSync: DateTime.now());

  bool loading = false;

  Future<void> loadAll() async {
    loading = true;
    notifyListeners();

    await _service.init();

    final permission = await _service.requestPermission();

    if (!permission) {
      loading = false;
      notifyListeners();
      return;
    }

    final bpm = await _service.getHeartRate();
    final spo2 = await _service.getSpo2();
    final steps = await _service.getSteps();
    final sleep = await _service.getSleep();

    healthStatus = HealthAnalyzer.analyze(
      heartRate: bpm,
      spo2: spo2,
      steps: steps,
      sleep: sleep,
    );

    loading = false;
    notifyListeners();
  }

  void startAdaptiveSync() {
    _syncManager.start(
      interval: healthStatus.syncInterval,
      onSync: () async {
        print("Auto Sync...");

        await loadAll();
      },
    );
  }

  void stopAdaptiveSync() {
    _syncManager.stop();
  }
}
