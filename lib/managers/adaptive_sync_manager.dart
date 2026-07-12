import 'dart:async';

class AdaptiveSyncManager {
  Timer? _timer;

  void start({
    required int interval,
    required Future<void> Function() onSync,
  }) {
    stop();

    _timer = Timer.periodic(
      Duration(seconds: interval),
      (_) async {
        await onSync();
      },
    );
  }

  void stop() {
    _timer?.cancel();
  }

  bool get isRunning => _timer != null;
}