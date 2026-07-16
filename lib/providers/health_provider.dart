import 'package:flutter/material.dart';
import 'package:health_monitor/models/health_result.dart';

import '../models/health_status.dart';
import '../services/health_services.dart';
import '../utils/health_analyzer.dart';
import '../managers/adaptive_sync_manager.dart';
import '../models/telemetry.dart';
import 'package:dio/dio.dart';

class HealthProvider extends ChangeNotifier {
  final HealthService _service = HealthService();
  final AdaptiveSyncManager _syncManager = AdaptiveSyncManager();
  List<Telemetry> histories = [];

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
    _syncManager.restart(
      interval: healthStatus.syncInterval,
      onSync: () async {
        await syncHealth();
      },
    );

    loading = false;
    notifyListeners();
  }

  void startAdaptiveSync() {
    _syncManager.start(
      interval: healthStatus.syncInterval,
      onSync: () async {
        await syncHealth();
      },
    );
  }

  void stopAdaptiveSync() {
    _syncManager.stop();
  }

  Future<void> syncHealth() async {
    try {
      loading = true;
      notifyListeners();

      await loadAll();

      final result = HealthResult(
        heartRate: healthStatus.heartRate ?? 0,
        spo2: healthStatus.spo2 ?? 0,
        temperature: 36.5,
        status: healthStatus.status,
        isAnomaly: healthStatus.status == "Danger",
        latitude: -6.2251,
        longitude: 106.8942,
        batteryLevel: 100,
      );

      final response = await _service.syncHealth(result);
      final data = response.data;

      healthStatus = healthStatus.copyWith(
        status: data["status"],
        syncInterval: (data["nextSyncMs"] as int) ~/ 1000,
        lastSync: DateTime.now(),
      );

      _syncManager.restart(
        interval: healthStatus.syncInterval,
        onSync: () async {
          await syncHealth();
        },
      );

      print(response.data);
    } catch (e) {
      if (e is DioException) {
        print("========== DIO ERROR ==========");
        print("URL       : ${e.requestOptions.uri}");
        print("METHOD    : ${e.requestOptions.method}");
        print("STATUS    : ${e.response?.statusCode}");
        print("RESPONSE  : ${e.response?.data}");
        print("===============================");
      } else {
        print(e);
      }
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> loadHistory(String lansiaId) async {
    loading = true;
    notifyListeners();

    try {
      histories = await _service.getHistory(lansiaId: lansiaId);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
