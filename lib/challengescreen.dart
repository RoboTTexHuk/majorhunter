import 'package:flutter/material.dart';

import 'secondchallengescreen.dart';

class ChallengeCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const ChallengeCard({
    required this.title,
    required this.description,
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Обработка нажатия на карточку
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChallengeDetailScreen(
              title: title,
              description: description,
              imagePath: imagePath,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Изображение
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Текстовые элементы
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.amber,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}





class ChallengeScreen extends StatelessWidget {
  const ChallengeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,

      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          ChallengeCard(
            title: 'A month without overspending',
            description: 'No extra spending for a month.',
            imagePath: 'assets/challenge1.png',
          ),
          SizedBox(height: 16),
          ChallengeCard(
            title: 'Daily piggy bank',
            description: 'Set aside a little bit each day.',
            imagePath: 'assets/challenge2.png',
          ),
          SizedBox(height: 16),
          ChallengeCard(
            title: 'Your personal challenge',
            description: 'Customize the challenge to your needs.',
            imagePath: 'assets/challenge3.png',
          ),
        ],
      ),
    );
  }
}