import 'package:flutter/material.dart';
import 'package:majorhunter/add.dart';
import 'package:majorhunter/challengescreen.dart';
import 'package:majorhunter/infoscreen.dart';
import 'package:majorhunter/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:graphic/graphic.dart';
class FinanceApp extends StatelessWidget {
  const FinanceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FinanceDashboard(),
    );
  }
}

class FinanceDashboard extends StatefulWidget {
  @override
  State<FinanceDashboard> createState() => _FinanceDashboardState();
}

class _FinanceDashboardState extends State<FinanceDashboard> {
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

  // Список экранов для отображения
  final List<Widget> _screens = [
    const HomeScreen(),
    const ChallengeScreen(),
    const ExpenseApp(),
    const MayorApp(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage(_imagePath ?? 'assets/character1.png'),
          ),
        ),
        title: const Text(
          'Mayor',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
       /* actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],*/
      ),
      body: _screens[_selectedTabIndex], // Меняем содержимое body в зависимости от выбранной вкладки
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey.shade800,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedTabIndex, // Устанавливаем текущий индекс
        onTap: (index) {
          setState(() {
            _selectedTabIndex = index; // Обновляем индекс при нажатии
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Main'),
          BottomNavigationBarItem(icon: Icon(Icons.flag), label: 'Challenge'),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.green,
              child: Icon(Icons.add, color: Colors.white),
            ),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// Экран "Главная"
// Экран "Главная"
// Экран "Главная"
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0; // Индекс выбранной вкладки
  final List<String> _tabTitles = ['Day', 'Week', 'Month', 'Year']; // Тексты для вкладок
  double _balance = 0; // Баланс по умолчанию
  double _totalValueIncome=0;
  double _totalValueE=0;

  List<Map<String, dynamic>> _chartData = [];
  List<Map<String, dynamic>> _chartData2 = [];// Данные для графика

  @override
  void initState() {
    super.initState();
    _loadChartData();
  }

  // Загрузка данных из SharedPreferences
  Future<void> _loadChartData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedData = prefs.getStringList('savedData') ?? [];

    setState(() {
      // Преобразуем данные в формат для графика
      _chartData = savedData.map((entry) {
        final parts = entry.split(': ');
        return {
          'label': parts[0],
          'value': double.parse(parts[1]),
        };
      }).toList();

      // Преобразуем данные только для категорий Salary, Investments, Gifts, Other
      _chartData2 = savedData
          .map((entry) {
        final parts = entry.split(': ');
        final categoryName = parts[0];
        final value = double.parse(parts[1]);

        // Фильтруем только нужные категории
        if (categoryName == 'Salary' ||
            categoryName == 'Investments' ||
            categoryName == 'Gifts' ||
            categoryName == 'Other') {
          return {
            'label': categoryName,
            'value': value,
          };
        }
        return null;
      })
          .where((entry) => entry != null) // Убираем null значения
          .cast<Map<String, dynamic>>() // Приводим к типу Map<String, dynamic>
          .toList();
      _totalValueIncome = _chartData.fold(0.0, (sum, item) => sum + (item['value'] as double));
      _totalValueE=_chartData2.fold(0.0, (sum, item) => sum + (item['value'] as double));
      _balance=_totalValueE+_totalValueIncome;
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Expenses, Income, Balance
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   _StatItem(label: 'Expenses', value: _totalValueE),
                   _StatItem(label: 'Income', value: _totalValueIncome),
                  _StatItem(label: 'Balance', value: _balance),
                ],
              ),
            ),
          ),
          // Day/Week/Month/Year Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  _tabTitles.length,
                      (index) => _TabItem(
                    label: _tabTitles[index],
                    isSelected: _selectedTabIndex == index,
                    onTap: () {
                      setState(() {
                        _selectedTabIndex = index; // Обновляем выбранный индекс
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // График из библиотеки graphic
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _chartData.isNotEmpty
                  ? Chart(
                data: _chartData,
                variables: {
                  'label': Variable(
                    accessor: (Map map) => map['label'] as String,
                  ),
                  'value': Variable(
                    accessor: (Map map) => map['value'] as num,
                  ),
                },
                marks: [
                  IntervalMark(
                    color: ColorEncode(value: Colors.amber),
                  ),
                ],
                axes: [
                  Defaults.horizontalAxis,
                  Defaults.verticalAxis,
                ],
                selections: {
                  'tap': PointSelection(
                    on: {GestureType.scaleUpdate, GestureType.tap},
                  ),
                },
                tooltip: TooltipGuide(),
                crosshair: CrosshairGuide(),
              )
                  : const Center(
                child: Text(
                  'No Data',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _chartData.isNotEmpty
                  ? Chart(
                data: _chartData2,
                variables: {
                  'label': Variable(
                    accessor: (Map map) => map['label'] as String,
                  ),
                  'value': Variable(
                    accessor: (Map map) => map['value'] as num,
                  ),
                },
                marks: [
                  IntervalMark(
                    color: ColorEncode(value: Colors.amber),
                  ),
                ],
                axes: [
                  Defaults.horizontalAxis,
                  Defaults.verticalAxis,
                ],
                selections: {
                  'tap': PointSelection(
                    on: {GestureType.scaleUpdate, GestureType.tap},
                  ),
                },
                tooltip: TooltipGuide(),
                crosshair: CrosshairGuide(),
              )
                  : const Center(
                child: Text(
                  'No Data',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _StatItem extends StatelessWidget {
  final String label;
  final double value;

  const _StatItem({required this.label,  required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value.toString(),
          style: const TextStyle(
            color: Colors.amber,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.amber : Colors.white,
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (isSelected)
              Container(
                margin: const EdgeInsets.only(top: 4),
                height: 2,
                width: 20,
                color: Colors.amber,
              ),
          ],
        ),
      ),
    );
  }
}
// Экран "Вызовы"


// Экран "Добавить"
class AddScreen extends StatelessWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Add Screen',
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }
}

// Экран "Информация"
class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Info Screen',
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }
}

