class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final bool isProfileComplete;
  final String? assignedArea;
  final DateTime? createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.isProfileComplete,
    this.assignedArea,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      role: json["role"],
      isProfileComplete: json["isProfileComplete"],
      assignedArea: json["assignedArea"],
      createdAt: json["createdAt"] != null
          ? DateTime.parse(json["createdAt"])
          : null,
    );
  }
}
