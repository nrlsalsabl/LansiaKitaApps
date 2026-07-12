import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color color;
    IconData icon;

    switch (status) {
      case "Normal":
        color = Colors.green;
        icon = Icons.check_circle;
        break;

      case "Warning":
        color = Colors.orange;
        icon = Icons.warning_amber;
        break;

      case "Danger":
        color = Colors.red;
        icon = Icons.error;
        break;

      default:
        color = Colors.grey;
        icon = Icons.help_outline;
    }

    return Chip(
      avatar: Icon(
        icon,
        color: color,
        size: 18,
      ),
      label: Text(status),
      backgroundColor: color.withValues(alpha: 0.15),
      side: BorderSide(
        color: color.withValues(alpha: 0.3),
      ),
      labelStyle: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
    );
  }
}