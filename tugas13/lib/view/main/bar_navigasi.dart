// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:tugas13/view/main/home/add_list.dart';
import 'package:tugas13/view/main/home/home.dart';
// import 'package:tugas13/view/main/about/about.dart';
// import 'package:tuuggaass13/view/main/about/about.dart';
// import 'package:tuuggaass13/view/main/home/add_list.dart';
// import 'package:tuuggaass13/view/main/home/home.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static const id = "/main";
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    AddShoppingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions[_selectedIndex]),

      // endDrawer: Drawer(child: Column(children: [])),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            // activeIcon: Icon(Icons.abc_outlined),
          ),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Tambah'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],

        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 240, 200, 241),
        unselectedItemColor: Colors.black,
        onTap: (value) {
          print(value);
          print("Nilai SelecetedIndex Before : $_selectedIndex");

          print("Nilai BotNav : $value");
          setState(() {
            _selectedIndex = value;
          });
          print("Nilai SelecetedIndex After: $_selectedIndex");
        },
        // onTap: _onItemTapped,
      ),
    );
  }
}

class AboutPage {
  const AboutPage();
}
