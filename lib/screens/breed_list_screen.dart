import 'package:flutter/material.dart';
import '../data/breeds.dart';
import '../widgets/breed_info_card.dart';

class BreedListScreen extends StatefulWidget {
  final Function(CatBreed) onBreedSelected;

  const BreedListScreen({
    super.key,
    required this.onBreedSelected,
  });

  @override
  State<BreedListScreen> createState() => _BreedListScreenState();
}

class _BreedListScreenState extends State<BreedListScreen> {
  String _searchQuery = '';
  String _selectedOrigin = 'Все';
  List<String> _origins = ['Все'];

  @override
  void initState() {
    super.initState();
    // Получаем уникальные происхождения
    final origins = breeds.map((breed) => breed.origin).toSet().toList();
    _origins.addAll(origins);
  }

  List<CatBreed> get _filteredBreeds {
    return breeds.where((breed) {
      final matchesSearch = breed.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          breed.temperament.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesOrigin = _selectedOrigin == 'Все' || breed.origin == _selectedOrigin;
      return matchesSearch && matchesOrigin;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 241, 228, 1),
      body: SafeArea(
        child: Column(
          children: [
            // Заголовок
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Text(
                    'Породы кошек',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'AbrilFatface',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      // Здесь можно добавить настройки или фильтры
                    },
                    icon: const Icon(Icons.filter_list),
                  ),
                ],
              ),
            ),

            // Поиск
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Поиск по названию или темпераменту...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Фильтр по происхождению
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _origins.length,
                itemBuilder: (context, index) {
                  final origin = _origins[index];
                  final isSelected = _selectedOrigin == origin;
                  
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedOrigin = origin;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        origin,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Счетчик результатов
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'Найдено: ${_filteredBreeds.length} пород',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Список пород
            Expanded(
              child: _filteredBreeds.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Породы не найдены',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Попробуйте изменить поисковый запрос',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _filteredBreeds.length,
                      itemBuilder: (context, index) {
                        final breed = _filteredBreeds[index];
                        return BreedInfoCard(
                          breed: breed,
                          onTap: () => widget.onBreedSelected(breed),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}