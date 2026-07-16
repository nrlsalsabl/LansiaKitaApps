import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/health_provider.dart';
import '../../widgets/health_card.dart';
// ignore: unused_import
import '../../widgets/status_badge.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = context.read<HealthProvider>();

      await provider.loadAll();

      provider.startAdaptiveSync();
    });
  }

  @override
  void dispose() {
    context.read<HealthProvider>().stopAdaptiveSync();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HealthProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Health Monitor"), centerTitle: true),
      body: provider.loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Icon(
                            provider.healthStatus.status == "Normal"
                                ? Icons.health_and_safety
                                : provider.healthStatus.status == "Warning"
                                ? Icons.warning_amber
                                : Icons.emergency,
                            size: 50,
                            color: provider.healthStatus.status == "Normal"
                                ? Colors.green
                                : provider.healthStatus.status == "Warning"
                                ? Colors.orange
                                : Colors.red,
                          ),

                          const SizedBox(height: 12),

                          Text(
                            provider.healthStatus.status,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            "Health Score : ${provider.healthStatus.score}/100",
                            style: const TextStyle(fontSize: 18),
                          ),

                          const SizedBox(height: 15),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Analysis",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),

                          const SizedBox(height: 10),

                          ...provider.healthStatus.reasons.map(
                            (e) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(child: Text(e)),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          Text(
                            "Adaptive Sync : ${provider.healthStatus.syncInterval} detik",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Heart Rate Card
                  HealthCard(
                    icon: Icons.favorite,
                    color: Colors.red,
                    title: "Heart Rate",
                    value: provider.healthStatus.heartRate == null
                        ? "-- BPM"
                        : "${provider.healthStatus.heartRate} BPM",
                  ),

                  const SizedBox(height: 16),

                  /// Status
                  // StatusBadge(status: provider.healthStatus.status),
                  // const SizedBox(height: 16),
                  HealthCard(
                    icon: Icons.bloodtype,
                    color: Colors.redAccent,
                    title: "SpO₂",
                    value: provider.healthStatus.spo2 == null
                        ? "-- %"
                        : "${provider.healthStatus.spo2} %",
                  ),

                  const SizedBox(height: 16),

                  HealthCard(
                    icon: Icons.directions_walk,
                    color: Colors.green,
                    title: "Steps",
                    value: provider.healthStatus.steps == null
                        ? "--"
                        : "${provider.healthStatus.steps}",
                  ),

                  const SizedBox(height: 16),

                  HealthCard(
                    icon: Icons.bedtime,
                    color: Colors.indigo,
                    title: "Sleep",
                    value: provider.healthStatus.sleep == null
                        ? "-- Jam"
                        : "${provider.healthStatus.sleep!.toStringAsFixed(1)} Jam",
                  ),

                  const SizedBox(height: 16),

                  /// Sync Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await provider.loadAll();
                      },
                      icon: const Icon(Icons.refresh),
                      label: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            await provider.syncHealth();

                            if (!context.mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Data berhasil dikirim"),
                              ),
                            );
                          },
                          icon: const Icon(Icons.cloud_upload),
                          label: const Text("Sync ke Server"),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "Last Sync",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    provider.healthStatus.lastSync.toString(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
    );
  }
}
