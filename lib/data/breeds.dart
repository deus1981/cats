import 'package:flutter/material.dart';
import '../data/breeds.dart';

class BreedDetailScreen extends StatelessWidget {
  final PageController controller;

  const BreedDetailScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      itemCount: breeds.length,
      itemBuilder: (context, index) {
        final breed = breeds[index];
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Image.asset(breed.image, height: 250),
                const SizedBox(height: 20),
                Text(
                  breed.name,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  breed.description,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
