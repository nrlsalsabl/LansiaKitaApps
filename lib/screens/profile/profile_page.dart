import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthProvider>().loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {

    final auth = context.watch<AuthProvider>();

    final user = auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const CircleAvatar(
              radius: 55,
              child: Icon(
                Icons.person,
                size: 55,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              user?.name ?? "-",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              user?.email ?? "-",
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            Card(
              child: Column(
                children: [

                  ListTile(
                    leading: const Icon(Icons.badge),
                    title: const Text("Role"),
                    subtitle: Text(user?.role ?? "-"),
                  ),

                  const Divider(height: 1),

                  ListTile(
                    leading: const Icon(Icons.location_on),
                    title: const Text("Assigned Area"),
                    subtitle: Text(user?.assignedArea ?? "-"),
                  ),

                  const Divider(height: 1),

                  ListTile(
                    leading: const Icon(Icons.verified_user),
                    title: const Text("Profile"),
                    subtitle: Text(
                      user?.isProfileComplete == true
                          ? "Completed"
                          : "Incomplete",
                    ),
                    trailing: Icon(
                      user?.isProfileComplete == true
                          ? Icons.check_circle
                          : Icons.cancel,
                      color: user?.isProfileComplete == true
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),

                  const Divider(height: 1),

                  ListTile(
                    leading: const Icon(Icons.calendar_month),
                    title: const Text("Created At"),
                    subtitle: Text(
                      user?.createdAt.toString() ?? "-",
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit),
                label: const Text("Edit Profile"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}