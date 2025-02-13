import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isSwitchOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            // Кнопка "Back"
            GestureDetector(
              onTap: () {
                Navigator.pop(context); // Вернуться назад
              },
              child: const Text(
                'Back',
                style: TextStyle(
                  color: Color(0xFFFFD700), // Желтый цвет
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Текст "On" и переключатель
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isSwitchOn ? 'On' : 'Off',
                  style: const TextStyle(
                    color: Color(0xFFFFD700), // Желтый цвет
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Switch(
                  value: isSwitchOn,
                  onChanged: (value) {
                    setState(() {
                      isSwitchOn = value;
                    });
                  },
                  activeColor: const Color(0xFFFFD700), // Желтый цвет
                  inactiveThumbColor: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SettingsScreen(),
  ));
}