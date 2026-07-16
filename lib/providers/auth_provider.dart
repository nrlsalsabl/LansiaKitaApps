import 'package:flutter/material.dart';

import '../models/login_request.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../services/session_service.dart';
import '../models/telemetry.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _service = AuthService();
  final SessionService _session = SessionService();

  bool loading = false;
  List<Telemetry> histories = [];

  User? currentUser;

  Future<bool> login({required String email, required String password}) async {
    try {
      loading = true;
      notifyListeners();

      final result = await _service.login(
        LoginRequest(email: email, password: password),
      );

      currentUser = result.user;

      await _session.saveToken(result.token);

      loading = false;
      notifyListeners();

      return true;
    } catch (e) {
      loading = false;
      notifyListeners();

      debugPrint(e.toString());

      return false;
    }
  }

  Future<void> loadProfile() async {
    currentUser = await _service.getProfile();

    notifyListeners();
  }

  Future<void> logout() async {
    currentUser = null;

    await _session.logout();

    notifyListeners();
  }

}
