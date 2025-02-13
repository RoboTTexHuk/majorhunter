import 'package:flutter/material.dart';
import 'package:majorhunter/mainMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';



class MajorHunterApp extends StatelessWidget {
  const MajorHunterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MajorHunterScreen(),
    );
  }
}

class MajorHunterScreen extends StatefulWidget {
  @override
  _MajorHunterScreenState createState() => _MajorHunterScreenState();
}

class _MajorHunterScreenState extends State<MajorHunterScreen> {
  int _selectedCharacterIndex = -1; // Индекс выбранного персонажа (-1: ничего не выбрано)
  String _enteredBudget = ''; // Введенный текст из TextField
  final List<String> _characterImagePaths = [
    'assets/character1.png',
    'assets/character2.png',
    'assets/character3.png',
  ]; // Пути к изображениям персонажей

  // Сохранение данных в SharedPreferences
  Future<void> _saveData() async {
    if (_selectedCharacterIndex == -1 || _enteredBudget.isEmpty) {
      return; // Не сохранять, если данные не полные
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedImagePath', _characterImagePaths[_selectedCharacterIndex]);
    await prefs.setString('enteredBudget', _enteredBudget);

    print('Data saved: ${_characterImagePaths[_selectedCharacterIndex]}, Budget: $_enteredBudget');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Welcome to',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const Text(
              '«Major Hunter»',
              style: TextStyle(
                color: Colors.amber,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Select a character',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            // Character selection (avatars)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCharacterAvatar(0),
                const SizedBox(width: 20),
                _buildCharacterAvatar(1),
                const SizedBox(width: 20),
                _buildCharacterAvatar(2),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              'Enter your monthly budget',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            // Budget input field
            Container(
              width: 120,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade700, width: 1),
                ),
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 20),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '1000',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _enteredBudget = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 40),
            // Main character image
            Expanded(
              child: Image.asset(
                'assets/pc.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Center(
                child: ElevatedButton(
                  onPressed: _isNextButtonEnabled()
                      ? () async {
                    await _saveData();
                    // Переход на другой экран (если нужно)
                    print('Next button pressed!');

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FinanceApp()),
                    );
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: Colors.amber,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Next'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCharacterAvatar(int index) {
    final isSelected = _selectedCharacterIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCharacterIndex = index;
        });
      },
      child: CircleAvatar(
        radius: 45,
        backgroundColor: isSelected ? Colors.green : Colors.grey.shade800,
        child: CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage(_characterImagePaths[index]),
        ),
      ),
    );
  }

  bool _isNextButtonEnabled() {
    return _selectedCharacterIndex != -1 && _enteredBudget.isNotEmpty;
  }
}