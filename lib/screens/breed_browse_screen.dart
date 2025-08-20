import 'package:flutter/material.dart';
import '../data/breeds.dart';

class BreedBrowseScreen extends StatefulWidget {
  final PageController controller;
  final Function(int) onSwipe;
  final VoidCallback? onClose;

  const BreedBrowseScreen({
    super.key,
    required this.controller,
    required this.onSwipe,
    this.onClose,
  });

  @override
  State<BreedBrowseScreen> createState() => _BreedBrowseScreenState();
}

class _BreedBrowseScreenState extends State<BreedBrowseScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sortedBreeds = List.of(breeds)..sort((a, b) => a.name.compareTo(b.name));

    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! > 1000 && widget.onClose != null) {
          widget.onClose!();
        }
      },
      child: PageView.builder(
        controller: widget.controller,
        itemCount: sortedBreeds.length,
        onPageChanged: widget.onSwipe,
        itemBuilder: (context, index) {
          final breed = sortedBreeds[index];

          return Stack(
            children: [
              // Фоновый контейнер и изображение
              Container(
                color: const Color.fromRGBO(247, 241, 228, 1),
                child: Center(
                  child: breed.isNetworkImage
                      ? FadeInImage.network(
                          placeholder: 'assets/images/placeholder.png',
                          image: breed.images.first,
                          fit: BoxFit.contain,
                          width: double.infinity,
                          height: double.infinity,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.pets,
                                size: 100,
                                color: Colors.grey,
                              ),
                            );
                          },
                        )
                      : Image.asset(
                          breed.images.first,
                          fit: BoxFit.contain,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.pets,
                                size: 100,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                ),
              ),

              // Градиентный оверлей для лучшей читаемости текста
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.3),
                      ],
                      stops: const [0.0, 0.6, 1.0],
                    ),
                  ),
                ),
              ),

              // Название приложения TheCats (в левом верхнем углу)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                    child: Row(
                      children: [
                        if (widget.onClose != null)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: IconButton(
                              onPressed: widget.onClose,
                              icon: const Icon(
                                Icons.close,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                          ),
                        Expanded(
                          child: Text(
                            'The Cats',
                            style: const TextStyle(
                              fontSize: 28,
                              fontFamily: 'AbrilFatface',
                              color: Colors.black,
                              shadows: [
                                Shadow(
                                  offset: Offset(1, 1),
                                  blurRadius: 3,
                                  color: Colors.white70,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Индикатор прогресса
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80.0, left: 40.0, right: 40.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: (index + 1) / sortedBreeds.length,
                            backgroundColor: Colors.black26,
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.black87),
                            minHeight: 3,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '${index + 1}/${sortedBreeds.length}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            shadows: [
                              Shadow(
                                offset: Offset(1, 1),
                                blurRadius: 2,
                                color: Colors.white70,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Название породы снизу по центру
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: FractionallySizedBox(
                        widthFactor: 0.8,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              breed.name,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: const TextStyle(
                                fontSize: 48,
                                fontFamily: 'AbrilFatface',
                                color: Colors.black,
                                height: 0.9,
                                shadows: [
                                  Shadow(
                                    offset: Offset(2, 2),
                                    blurRadius: 4,
                                    color: Colors.white70,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              breed.origin,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                shadows: [
                                  Shadow(
                                    offset: const Offset(1, 1),
                                    blurRadius: 2,
                                    color: Colors.white70,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Индикатор свайпа
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Свайп для просмотра',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}