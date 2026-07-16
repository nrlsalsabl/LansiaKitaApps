import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const _token = "token";

  Future<void> saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_token, token);
  }

  Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(_token);
  }

  Future<void> logout() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(_token);
  }

  Future<bool> isLogin() async {
    return (await getToken()) != null;
  }
}
