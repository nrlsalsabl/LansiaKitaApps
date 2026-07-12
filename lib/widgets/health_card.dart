import 'package:flutter/material.dart';

class HealthCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String value;
  final String? subtitle;

  const HealthCard({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.value,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              // ignore: deprecated_member_use
              backgroundColor: color.withOpacity(.15),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  if (subtitle != null)
                    Text(subtitle!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}