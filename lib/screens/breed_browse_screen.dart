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

  double _dragOffset = 0;
  bool _isClosing = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;

    _imagePageController = PageController();
    _scrollController = ScrollController();
  }

  // 🔥 iOS / TikTok style dismiss
  void _onDragUpdate(DragUpdateDetails details) {
    if (_isClosing) return;

    setState(() {
      _dragOffset += details.delta.dy;
      if (_dragOffset < 0) _dragOffset = 0;
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (_isClosing) return;

    final velocity = details.primaryVelocity ?? 0;

    final shouldClose = _dragOffset > 120 || velocity > 800;

    if (shouldClose) {
      _closeWithAnimation();
    } else {
      setState(() {
        _dragOffset = 0;
      });
    }
  }

  void _closeWithAnimation() {
    if (_isClosing) return;

    _isClosing = true;
    Navigator.of(context).pop();
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
        onVerticalDragUpdate: _onDragUpdate,
        onVerticalDragEnd: _onDragEnd,

        child: Transform.translate(
          offset: Offset(0, _dragOffset),

          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 4),

                // 🔹 Название породы
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

                // 🔹 Картинка
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: PageView.builder(
                    controller: _imagePageController,
                    itemCount: images.length,
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

                // 🔹 Описание
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
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
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 80),
                      ],
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