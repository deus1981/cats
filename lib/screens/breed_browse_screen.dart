import 'package:flutter/material.dart';
import '../data/breeds.dart';

class BreedBrowseScreen extends StatelessWidget {
  final PageController controller;
  final Function(int) onSwipe;

  const BreedBrowseScreen({
    super.key,
    required this.controller,
    required this.onSwipe,
  });

  @override
  Widget build(BuildContext context) {
    final sortedBreeds = List.of(breeds)..sort((a, b) => a.name.compareTo(b.name));

    return PageView.builder(
      controller: controller,
      itemCount: sortedBreeds.length,
      onPageChanged: onSwipe,
      itemBuilder: (context, index) {
        final breed = sortedBreeds[index];

        return Stack(
          children: [
            // Фоновый контейнер и изображение
            Container(
              color: const Color.fromRGBO(247, 241, 228, 1), // Эталонный цвет фона
              child: Center(
                child: Image.asset(
                  breed.images.first,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),

            // Название приложения TheCats (в левом верхнем углу с отступом 15%)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 40.0), // 40 пикселей
                  child: Text(
                    'TheCats',
                    style: const TextStyle(
                      fontSize: 28,
                      fontFamily: 'AbrilFatface',
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),

            // Название породы снизу по центру
            // Замените текущий Align(...) на это:
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: FractionallySizedBox(
                  widthFactor: 0.8, // Ограничим ширину до 80% экрана
                  child: Text(
                    breed.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 48,
                      fontFamily: 'AbrilFatface',
                      color: Colors.black,
                      height: 0.9, // 👈 Это уменьшает расстояние между строками
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}