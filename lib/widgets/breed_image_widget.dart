import 'package:flutter/material.dart';

class BreedImageGallery extends StatelessWidget {
  final List<String> images;

  const BreedImageGallery({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Center(
          child: Image.asset(
            images[index],
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }
}