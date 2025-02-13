
import 'package:flutter/material.dart';





class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;

  const CustomBottomNavigationBar({
    required this.selectedIndex,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.grey.shade800,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.amber,
      unselectedItemColor: Colors.grey,
      currentIndex: selectedIndex,
      onTap: (index) {
        // Обработка нажатий
        switch (index) {
          case 0:
          // Переход на главную
            break;
          case 1:
          // Переход на вызовы


            break;
          case 2:
          // Открытие модального окна (например, добавление нового вызова)
            break;
          case 3:
          // Переход на страницу информации
            break;
          case 4:
          // Переход на профиль
            break;
        }
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
    );
  }
}