import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ExpenseScreen(),
    );
  }
}

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key? key}) : super(key: key);

  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  bool isExpensesSelected = true;
  String inputAmount = '0';
  int? selectedCategoryIndex;

  // Список сохранённых данных
  List<String> savedData = [];

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  // Загрузка сохранённых данных из SharedPreferences
  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedData = prefs.getStringList('savedData') ?? [];
    });
  }

  // Сохранение данных в SharedPreferences
  Future<void> _saveData(String category, String amount) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedData.add('$category: $amount');
    });
    await prefs.setStringList('savedData', savedData);
  }

  void _onKeyboardTap(String value) {
    setState(() {
      if (value == 'back') {
        inputAmount = inputAmount.isNotEmpty
            ? inputAmount.substring(0, inputAmount.length - 1)
            : '0';
      } else {
        if (inputAmount == '0') {
          inputAmount = value;
        } else {
          inputAmount += value;
        }
      }
    });
  }

  void _onOkPressed() {
    if (selectedCategoryIndex != null && inputAmount.isNotEmpty) {
      final categoryName = (isExpensesSelected ? expenseCategories : incomeCategories)[selectedCategoryIndex!]['name'] as String;

      // Сохранение в SharedPreferences
      _saveData(categoryName, inputAmount);

      setState(() {
        // Сбрасываем состояние
        selectedCategoryIndex = null;
        inputAmount = '0';
      });

      // Печатаем для проверки
      print('Saved Data: $savedData');
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = isExpensesSelected ? expenseCategories : incomeCategories;

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Переключатель "Expenses" и "Income"
              Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpensesSelected = true;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          decoration: BoxDecoration(
                            color: isExpensesSelected
                                ? Colors.grey.shade900
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Expenses',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isExpensesSelected
                                  ? Colors.white
                                  : Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpensesSelected = false;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          decoration: BoxDecoration(
                            color: !isExpensesSelected
                                ? Colors.grey.shade900
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Income',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: !isExpensesSelected
                                  ? Colors.white
                                  : Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Сетка категорий
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Четыре элемента в строке
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategoryIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategoryIndex = index;
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? Colors.green
                                  : category['borderColor'] as Color,
                              width: 2,
                            ),
                            image: DecorationImage(
                              image:
                              AssetImage(category['imagePath'] as String),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category['name'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Цифровая клавиатура и поле ввода
              if (selectedCategoryIndex != null)
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.calendar_today, color: Colors.white),
                          const SizedBox(width: 8),
                          const Text(
                            'Today',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              inputAmount,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: 12,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemBuilder: (context, index) {
                          final keys = [
                            '1',
                            '2',
                            '3',
                            '4',
                            '5',
                            '6',
                            '7',
                            '8',
                            '9',
                            '0',
                            'back'
                          ];
                          final value = index < keys.length ? keys[index] : '';
                          if (value.isEmpty) return const SizedBox.shrink();

                          return GestureDetector(
                            onTap: () => _onKeyboardTap(value),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: value == 'back'
                                    ? Colors.red
                                    : Colors.amber.shade800,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: value == 'back'
                                  ? const Icon(Icons.backspace,
                                  color: Colors.white)
                                  : Text(
                                value,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _onOkPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Ok',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              // Отображение сохранённых данных
              const Text(
                'Saved Data:',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              ...savedData.map((data) => Text(
                data,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

// Категории для расходов
final List<Map<String, dynamic>> expenseCategories = [
  {
    'name': 'Attractions',
    'imagePath': 'assets/attractions.png',
    'borderColor': Colors.purple,
  },
  {
    'name': 'Education',
    'imagePath': 'assets/education.png',
    'borderColor': Colors.blue,
  },
  {
    'name': 'Home',
    'imagePath': 'assets/home.png',
    'borderColor': Colors.orange,
  },
  {
    'name': 'Medicine',
    'imagePath': 'assets/medicine.png',
    'borderColor': Colors.green,
  },
  {
    'name': 'Products',
    'imagePath': 'assets/products.png',
    'borderColor': Colors.yellow,
  },
  {
    'name': 'Transport',
    'imagePath': 'assets/transport.png',
    'borderColor': Colors.red,
  },
  {
    'name': 'Shopping',
    'imagePath': 'assets/shopping.png',
    'borderColor': Colors.purpleAccent,
  },
  {
    'name': 'Other',
    'imagePath': 'assets/other.png',
    'borderColor': Colors.cyan,
  },
];

// Категории для доходов
final List<Map<String, dynamic>> incomeCategories = [
  {
    'name': 'Salary',
    'imagePath': 'assets/salary.png',
    'borderColor': Colors.green,
  },
  {
    'name': 'Investments',
    'imagePath': 'assets/investments.png',
    'borderColor': Colors.blue,
  },
  {
    'name': 'Gifts',
    'imagePath': 'assets/gifts.png',
    'borderColor': Colors.purple,
  },
  {
    'name': 'Other',
    'imagePath': 'assets/other_income.png',
    'borderColor': Colors.orange,
  },
];