import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/health_provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final auth = context.read<AuthProvider>();
      final health = context.read<HealthProvider>();

      // Kalau user belum ada (misalnya buka aplikasi lagi)
      if (auth.currentUser == null) {
        await auth.loadProfile();
      }

      if (auth.currentUser != null) {
        await health.loadHistory(auth.currentUser!.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HealthProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Riwayat Kesehatan")),

      body: provider.loading
          ? const Center(child: CircularProgressIndicator())
          : provider.histories.isEmpty
          ? const Center(child: Text("Belum ada riwayat kesehatan"))
          : ListView.builder(
              itemCount: provider.histories.length,

              itemBuilder: (_, index) {
                final item = provider.histories[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),

                  child: ListTile(
                    leading: Icon(
                      Icons.favorite,

                      color: item.status == "DARURAT"
                          ? Colors.red
                          : item.status == "PERLU_PANTAU"
                          ? Colors.orange
                          : Colors.green,
                    ),

                    title: Text("${item.heartRate} BPM"),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("SpO₂ : ${item.spo2}%"),

                        Text("Suhu : ${item.temperature}°C"),

                        Text(item.timestamp.toString()),
                      ],
                    ),

                    trailing: Chip(label: Text(item.status)),
                  ),
                );
              },
            ),
    );
  }
}
