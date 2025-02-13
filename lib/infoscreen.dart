import 'package:flutter/material.dart';
import 'package:majorhunter/infotwo.dart';



class MayorApp extends StatelessWidget {
  const MayorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MayorScreen(),
    );
  }
}

class MayorScreen extends StatelessWidget {
  const MayorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Welcome to the mayor of the city and I will be happy to share with you some useful financial advice.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Фоновые круги
                  Positioned(
                    top: 100,
                    left: 50,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade700.withOpacity(0.3),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    right: 50,
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade700.withOpacity(0.3),
                      ),
                    ),
                  ),
                  // Монеты
                  Positioned(
                    top: 80,
                    left: 100,
                    child: const Icon(
                      Icons.circle,
                      color: Colors.amber,
                      size: 20,
                    ),
                  ),
                  Positioned(
                    top: 130,
                    left: 130,
                    child: const Icon(
                      Icons.monetization_on,
                      color: Colors.amber,
                      size: 40,
                    ),
                  ),
                  Positioned(
                    top: 160,
                    left: 80,
                    child: const Icon(
                      Icons.monetization_on_outlined,
                      color: Colors.amber,
                      size: 30,
                    ),
                  ),
                  // Изображение мэра
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/mayor_image.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Кнопка "Get advice"
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BudgetingApp()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Get advice',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}