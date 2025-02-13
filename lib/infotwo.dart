import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BudgetingApp extends StatelessWidget {
  const BudgetingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BudgetingScreen(),
    );
  }
}
class BudgetingScreen extends StatefulWidget {
  const BudgetingScreen({super.key});

  @override
  State<BudgetingScreen> createState() => _BudgetingScreenState();
}

class _BudgetingScreenState extends State<BudgetingScreen> {

  String? _imagePath; // Путь к изображению аватара
  String _balance = '0'; // Баланс по умолчанию
  int _selectedTabIndex = 0; // Индекс выбранной вкладки

  @override
  void initState() {
    super.initState();
    _loadData(); // Загружаем данные при инициализации
  }

  // Метод для загрузки данных из SharedPreferences
  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _imagePath = prefs.getString('selectedImagePath') ?? 'assets/character1.png';
      _balance = prefs.getString('enteredBudget') ?? '0';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Карточка с информацией
            Card(
              color: const Color(0xFF2C2C2E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    // Заголовок
                    Text(
                      'Budgeting and Expense Tracking',
                      style: TextStyle(
                        color: Color(0xFFFFD700), // Желтый цвет
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Список с маркерами
                    Text(
                      '• Freelancing: Offer your skills (e.g., graphic design, writing, coding) on platforms like Upwork, Fiverr, or Freelancer.\n\n'
                          '• Online Tutoring: Teach a subject you\'re skilled in through platforms like VIPKid, Wyzant, or Preply.\n\n'
                          '• Selling Products: Sell handmade items on Etsy. Declutter and sell unused items on eBay, Poshmark, or Facebook Marketplace.',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            // Кнопка
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF34C759), // Зеленый цвет кнопки
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                ),
                child: const Text(
                  'Get another',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
