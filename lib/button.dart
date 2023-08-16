import 'package:flutter/material.dart';
import 'package:getmetour/home.dart';
import 'package:getmetour/jadwal.dart';

class Button extends StatefulWidget {
  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    MainScreen(), // Ganti dengan nama halaman yang sesuai
    JadwalScreen(), // Ganti dengan nama halaman yang sesuai
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.note_add_rounded), label: "Jadwal"),
        ],
      ),
    );
  }
}
