// class Api {
//   // Emulator Android
//   // static const String baseUrl = "http://10.0.2.2:3000/api/mobile";

//  // ganti jadi IP laptop
//   static const String baseUrl = "http://192.168.1.61:3000/api/mobile";

//   static const login = "/auth/login";

//   static const profile = "/profile";

//   static const health = "/health";

//   static const syncHealth = "/iot/status";
//   static const history = "/api/iot/status";
// }

class Api {
  // ganti jdi ip laptop
  static const String baseUrl = "http://192.168.1.61:3000";

  static const login = "/api/mobile/auth/login";
  static const profile = "/api/mobile/auth/me";

  static const syncHealth = "/api/iot/status";
  static const history = "/api/iot/status";
}