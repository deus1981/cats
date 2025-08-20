import 'package:flutter/material.dart';
import '../data/breeds.dart';

class BreedDetailScreen extends StatelessWidget {
  final CatBreed breed;

  const BreedDetailScreen({
    super.key,
    required this.breed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 241, 228, 1),
      body: CustomScrollView(
        slivers: [
          // App Bar с изображением
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            backgroundColor: const Color.fromRGBO(247, 241, 228, 1),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  // Основное изображение
                  breed.isNetworkImage
                      ? FadeInImage.network(
                          placeholder: 'assets/images/placeholder.png',
                          image: breed.images.first,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Container(
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
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.pets,
                                size: 100,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                  
                  // Градиентный оверлей
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.3),
                            Colors.black.withOpacity(0.6),
                          ],
                          stops: const [0.0, 0.6, 1.0],
                        ),
                      ),
                    ),
                  ),
                  
                  // Название породы поверх изображения
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Text(
                      breed.name,
                      style: const TextStyle(
                        fontSize: 36,
                        fontFamily: 'AbrilFatface',
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(2, 2),
                            blurRadius: 4,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          
          // Основной контент
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Основная информация
                  _buildInfoSection(
                    title: 'Основная информация',
                    children: [
                      _buildInfoRow('Происхождение', breed.origin, Icons.location_on),
                      _buildInfoRow('Продолжительность жизни', breed.lifeSpan, Icons.timer),
                      _buildInfoRow('Вес', breed.weight, Icons.monitor_weight),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Темперамент
                  _buildInfoSection(
                    title: 'Темперамент',
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: breed.temperament.split(', ').map((trait) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              trait.trim(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Описание
                  _buildInfoSection(
                    title: 'Описание',
                    children: [
                      Text(
                        breed.description,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.6,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Галерея изображений
                  if (breed.images.length > 1)
                    _buildInfoSection(
                      title: 'Галерея',
                      children: [
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: breed.images.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(right: 12),
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: breed.isNetworkImage
                                      ? FadeInImage.network(
                                          placeholder: 'assets/images/placeholder.png',
                                          image: breed.images[index],
                                          fit: BoxFit.cover,
                                          imageErrorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.grey[300],
                                              child: const Icon(
                                                Icons.pets,
                                                size: 40,
                                                color: Colors.grey,
                                              ),
                                            );
                                          },
                                        )
                                      : Image.asset(
                                          breed.images[index],
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.grey[300],
                                              child: const Icon(
                                                Icons.pets,
                                                size: 40,
                                                color: Colors.grey,
                                              ),
                                            );
                                          },
                                        ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontFamily: 'AbrilFatface',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
