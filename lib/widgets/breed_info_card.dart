import 'package:flutter/material.dart';
import '../data/breeds.dart';

class BreedInfoCard extends StatelessWidget {
  final CatBreed breed;
  final VoidCallback? onTap;

  const BreedInfoCard({
    super.key,
    required this.breed,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Изображение породы
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: breed.isNetworkImage
                    ? FadeInImage.network(
                        placeholder: 'assets/images/placeholder.png',
                        image: breed.images.first,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.pets,
                              size: 50,
                              color: Colors.grey,
                            ),
                          );
                        },
                      )
                    : Image.asset(
                        breed.images.first,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.pets,
                              size: 50,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
              ),
            ),
            
            // Информация о породе
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Название породы
                  Text(
                    breed.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'AbrilFatface',
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Происхождение
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        breed.origin,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Темперамент
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: breed.temperament.split(', ').map((trait) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(247, 241, 228, 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          trait.trim(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  
                  // Дополнительная информация
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoItem(
                          icon: Icons.timer,
                          label: 'Продолжительность жизни',
                          value: breed.lifeSpan,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildInfoItem(
                          icon: Icons.monitor_weight,
                          label: 'Вес',
                          value: breed.weight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: Colors.grey[600],
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}