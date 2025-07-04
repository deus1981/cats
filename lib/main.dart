import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/breed_browse_screen';
import 'screens/breed_detail_screen';
import 'package:cats/data/breeds.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RootPager(),
    );
  }
}

class RootPager extends StatefulWidget {
  const RootPager({super.key});

  @override
  State<RootPager> createState() => _RootPagerState();
}

class _RootPagerState extends State<RootPager> {
  final PageController _verticalController = PageController();
  PageController? _horizontalController;
  int _initialIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadLastBreedIndex();
  }

  Future<void> _loadLastBreedIndex() async {
    final prefs = await SharedPreferences.getInstance();
    _initialIndex = prefs.getInt('last_breed_index') ?? 0;
    setState(() {
      _horizontalController = PageController(initialPage: _initialIndex);
    });
  }

  void _saveIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('last_breed_index', index);
  }

  @override
  Widget build(BuildContext context) {
    if (_horizontalController == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return PageView(
      controller: _verticalController,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      children: [
        // Экран приветствия
        GestureDetector(
          onTap: () => _verticalController.animateToPage(
            1,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          ),
          child: Container(
            color: const Color.fromRGBO(239, 225, 200, 1),
            child: const Center(
              child: Text('Tap to Start', style: TextStyle(fontSize: 32)),
            ),
          ),
        ),

        // Экран выбора породы
        BreedBrowseScreen(
          controller: _horizontalController!,
          onScrollDown: () => _verticalController.animateToPage(
            2,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          ),
          onPageChanged: _saveIndex,
        ),

        // Экран описания породы
        BreedDetailScreen(controller: _horizontalController!),
      ],
    );
  }
}