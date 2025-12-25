import 'package:flutter/material.dart';
import 'screens/breed_browse_screen.dart';
import 'screens/breed_detail_screen.dart';
import 'data/breeds.dart';

void main() {
  runApp(const TheCatsApp());
}

class TheCatsApp extends StatelessWidget {
  const TheCatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Cats',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(247, 241, 228, 1),
        fontFamily: 'RobotoSlab',
      ),
      home: const RootPager(),
    );
    
  }
}

class RootPager extends StatefulWidget {
  const RootPager({super.key});

  @override
  State<RootPager> createState() => _RootPagerState();
}

class _RootPagerState extends State<RootPager> {
  final PageController _horizontalController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _horizontalController,
      scrollDirection: Axis.vertical,
      children: [
        // Экран 1: Галерея пород
        BreedBrowseScreen(
          controller: _horizontalController,
          onSwipe: (index) {
            setState(() => _currentIndex = index);
          },
        ),

        // Экран 2: Детали выбранной породы
        BreedDetailScreen(initialIndex: _currentIndex),
      ],
    );
  }
}
