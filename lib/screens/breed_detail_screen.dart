import 'package:flutter/material.dart';
import 'package:cats/data/breeds.dart';

class BreedDetailScreen extends StatefulWidget {
  final int initialIndex;

  const BreedDetailScreen({super.key, required this.initialIndex});

  @override
  State<BreedDetailScreen> createState() => _BreedDetailScreenState();
}

class _BreedDetailScreenState extends State<BreedDetailScreen> {
  late PageController _imagePageController;
  late ScrollController _scrollController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _imagePageController = PageController();
    _scrollController = ScrollController();
  }

  void _handleVerticalDrag(DragEndDetails details) {
    if (details.primaryVelocity != null && details.primaryVelocity! > 500) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _imagePageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final breed = breeds[_currentIndex];
    final images = breed.images;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F1E4),
      body: GestureDetector(
        onVerticalDragEnd: _handleVerticalDrag,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 4),

              // Название породы
              Text(
                breed.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontFamily: 'AbrilFatface',
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 4),

              // Картинка кота (с горизонтальным скроллом)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                child: PageView.builder(
                  controller: _imagePageController,
                  itemCount: images.length,
                  onPageChanged: (index) {
                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    final image = images[index % images.length];
                    return Image.asset(
                      image,
                      fit: BoxFit.contain,
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              // Текстовое описание
              Expanded(
                child: NotificationListener<ScrollEndNotification>(
                  onNotification: (notification) {
                    if (_scrollController.offset <= 0 &&
                        notification is ScrollEndNotification) {
                      Navigator.pop(context);
                    }
                    return false;
                  },
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _infoRow("Origin", breed.origin),
                        _infoRow("Temperament", breed.temperament),
                        _infoRow("Life Span", breed.lifeSpan),
                        _infoRow("Weight", breed.weight),
                        const SizedBox(height: 20),
                        const Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          breed.description,
                          style: const TextStyle(fontSize: 16, height: 1.5),
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$label:",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
