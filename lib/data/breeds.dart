// lib/data/breeds.dart

class CatBreed {
  final String name;
  final String origin;
  final String temperament;
  final String lifeSpan;
  final String weight;
  final String description;
  final List<String> images;
  final bool isNetworkImage; // Новое поле для определения типа изображения

  CatBreed({
    required this.name,
    required this.origin,
    required this.temperament,
    required this.lifeSpan,
    required this.weight,
    required this.description,
    required this.images,
    this.isNetworkImage = false, // По умолчанию локальные изображения
  });
}

final List<CatBreed> breeds = [
  CatBreed(
    name: 'Abyssinian',
    origin: 'Ethiopia',
    temperament: 'Active, Playful, Intelligent, Curious',
    lifeSpan: '14-15 years',
    weight: '6-10 lbs',
    description:
    'The Abyssinian is a breed of domestic short-haired cat with a distinctive "ticked" tabby coat, in which individual hairs are banded with different colors. They are medium-sized cats with a lithe, muscular body and large, alert ears. Abyssinians are known for their intelligence, playfulness, and extroverted personality.\n\nThese cats are extremely active and love to climb and explore. They are often described as dog-like in their loyalty and will follow their owners around the house. Abyssinians are also known for their soft, chirping voice and their love of interactive play.\n\nThe breed originated in Ethiopia (formerly Abyssinia) and was brought to England in the 1860s.',
    images: [
      'assets/images/abyssinian_1.png',
      'assets/images/abyssinian_2.png',
      'assets/images/abyssinian_3.png',
    ],
  ),
  CatBreed(
    name: 'Bengal',
    origin: 'United States',
    temperament: 'Active, Intelligent, Curious, Athletic',
    lifeSpan: '12-16 years',
    weight: '8-15 lbs',
    description:
    'The Bengal cat is a domesticated cat breed created from hybrids of domestic cats, especially the spotted Egyptian Mau, with the Asian leopard cat. Bengals have a wild appearance with large spots and rosettes, and a body structure reminiscent of the Asian Leopard Cat.\n\nThey are known for their intelligence, curiosity, and high energy levels. They often enjoy playing in water, climbing to high places, and interactive play. Many Bengals can be leash trained and enjoy going for walks. They are vocal cats and often "talk" to their owners with chirps, chatters, and trills.',
    images: [
      'assets/images/bengal_1.png',
      'assets/images/bengal_2.png',
      'assets/images/bengal_3.png',
    ],
  ),
  CatBreed(
    name: 'British Shorthair',
    origin: 'United Kingdom',
    temperament: 'Calm, Easygoing, Affectionate, Loyal',
    lifeSpan: '12-20 years',
    weight: '9-17 lbs',
    description:
    'The British Shorthair is known for its dense coat, broad face, and stocky body. These cats are quiet and gentle, making them ideal companions. They are not typically lap cats but enjoy being near their humans and are very loyal.\n\nThey are independent but affectionate, get along well with children and other pets, and have a calm, dignified presence. The British Shorthair\'s plush coat comes in many colors, but the "British Blue" (a solid grey-blue) is especially popular.',
    images: [
      'assets/images/british_shorthair_1.png',
      'assets/images/british_shorthair_2.png',
      'assets/images/british_shorthair_3.png',
    ],
  ),
  // Добавим несколько новых пород для демонстрации
  CatBreed(
    name: 'Maine Coon',
    origin: 'United States',
    temperament: 'Gentle, Intelligent, Playful, Loyal',
    lifeSpan: '12-15 years',
    weight: '10-18 lbs',
    description:
    'The Maine Coon is one of the largest domesticated cat breeds. They are known for their intelligence and gentle personality, making them excellent family pets. They are also known for their hunting skills and love of water.',
    images: [
      'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?w=800',
      'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?w=800',
      'https://images.unsplash.com/photo-1543852786-1cf6624b3ddf?w=800',
    ],
    isNetworkImage: true,
  ),
  CatBreed(
    name: 'Siamese',
    origin: 'Thailand',
    temperament: 'Social, Intelligent, Vocal, Active',
    lifeSpan: '15-20 years',
    weight: '8-15 lbs',
    description:
    'Siamese cats are known for their distinctive color points and blue eyes. They are highly social, intelligent, and vocal cats that form strong bonds with their owners. They are also known for their playful and active nature.',
    images: [
      'https://images.unsplash.com/photo-1513360371669-4adf3dd7dff8?w=800',
      'https://images.unsplash.com/photo-1574158622682-e40e4698105d?w=800',
      'https://images.unsplash.com/photo-1543852786-1cf6624b3ddf?w=800',
    ],
    isNetworkImage: true,
  ),
];
