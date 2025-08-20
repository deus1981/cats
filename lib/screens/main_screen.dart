import 'package:flutter/material.dart';
import '../data/breeds.dart';
import 'breed_browse_screen.dart';
import 'breed_list_screen.dart';
import 'breed_detail_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onSwipe(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onBreedSelected(CatBreed breed) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BreedDetailScreen(breed: breed),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 241, 228, 1),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // Экран просмотра пород
          BreedBrowseScreen(
            controller: _pageController,
            onSwipe: _onSwipe,
            onClose: () {
              setState(() {
                _currentIndex = 1;
              });
            },
          ),
          
          // Экран списка пород
          BreedListScreen(
            onBreedSelected: _onBreedSelected,
          ),
        ],
      ),
      
      // Нижняя навигация
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                // Кнопка просмотра
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentIndex = 0;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _currentIndex == 0 
                            ? Colors.black 
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.view_carousel,
                            color: _currentIndex == 0 
                                ? Colors.white 
                                : Colors.black54,
                            size: 24,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Просмотр',
                            style: TextStyle(
                              fontSize: 12,
                              color: _currentIndex == 0 
                                  ? Colors.white 
                                  : Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Кнопка списка
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _currentIndex == 1 
                            ? Colors.black 
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.list,
                            color: _currentIndex == 1 
                                ? Colors.white 
                                : Colors.black54,
                            size: 24,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Список',
                            style: TextStyle(
                              fontSize: 12,
                              color: _currentIndex == 1 
                                  ? Colors.white 
                                  : Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}