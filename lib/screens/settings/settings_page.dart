import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notification = true;
  bool autoSync = true;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings"), centerTitle: true),
      body: ListView(
        children: [
          const SizedBox(height: 12),

          /// Notification
          SwitchListTile(
            value: notification,
            onChanged: (value) {
              setState(() {
                notification = value;
              });
            },
            secondary: const Icon(Icons.notifications),
            title: const Text("Notification"),
            subtitle: const Text("Receive health alerts"),
          ),

          /// Auto Sync
          SwitchListTile(
            value: autoSync,
            onChanged: (value) {
              setState(() {
                autoSync = value;
              });
            },
            secondary: const Icon(Icons.sync),
            title: const Text("Auto Sync"),
            subtitle: const Text("Automatically sync health data"),
          ),

          /// Dark Mode
          SwitchListTile(
            value: darkMode,
            onChanged: (value) {
              setState(() {
                darkMode = value;
              });
            },
            secondary: const Icon(Icons.dark_mode),
            title: const Text("Dark Mode"),
            subtitle: const Text("Coming Soon"),
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About"),
            subtitle: const Text("Health Monitor v1.0"),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "Health Monitor",
                applicationVersion: "1.0.0",
                applicationLegalese: "© 2026",
              );
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () async {
              final auth = context.read<AuthProvider>();

              await auth.logout();

              if (!context.mounted) return;

              context.go("/login");
            },
          ),
        ],
      ),
    );
  }
}
