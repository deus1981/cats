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
            Container(
              color: const Color.fromRGBO(239, 225, 200, 1),
              child: Center(
                child: Image.asset(
                  breed.images.first,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Text(
                  breed.name,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
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