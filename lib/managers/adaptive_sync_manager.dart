import 'dart:async';

class AdaptiveSyncManager {
  Timer? _timer;

  int? _currentInterval;

  void start({
    required int interval,
    required Future<void> Function() onSync,
  }) {
    stop();

    _currentInterval = interval;

    _timer = Timer.periodic(
      Duration(seconds: interval),
      (_) async {
        await onSync();
      },
    );
  }

  void restart({
    required int interval,
    required Future<void> Function() onSync,
  }) {
    if (_currentInterval == interval && isRunning) {
      return;
    }

    start(
      interval: interval,
      onSync: onSync,
    );
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  bool get isRunning => _timer != null;
}