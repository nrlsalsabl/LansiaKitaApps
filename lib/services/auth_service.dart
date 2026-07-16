import 'package:health_monitor/models/user.dart';

import '../constants/api.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _api = ApiService();

 Future<LoginResponse> login(LoginRequest request) async {
  final response = await _api.dio.post(
    Api.login,
    data: request.toJson(),
  );

  print("URL: ${response.realUri}");
  print("STATUS: ${response.statusCode}");
  print("DATA: ${response.data}");

  return LoginResponse.fromJson(response.data);
}

  Future<User> getProfile() async {
    final response = await _api.dio.get("/api/mobile/auth/me");

    return User.fromJson(response.data["user"]);
  }
}
