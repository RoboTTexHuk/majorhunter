import 'package:flutter/material.dart';
import 'package:majorhunter/analistic.dart';
import 'package:majorhunter/notif.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Список элементов
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              tileColor: const Color(0xFF2C2C2E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text(
                'Analytics',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              trailing: const Icon(Icons.chevron_right, color: Color(0xFFFFD700)),
              onTap: () {
                // Действие при нажатии

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AnalyticsScreen()),
                );
              },
            ),
            const SizedBox(height: 16),

            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              tileColor: const Color(0xFF2C2C2E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text(
                'Notifications',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              trailing: const Icon(Icons.chevron_right, color: Color(0xFFFFD700)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );

                // Действие при нажатии
              },
            ),
          ],
        ),
      ),


    );
  }
}

