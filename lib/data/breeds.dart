// lib/data/breeds.dart

class CatBreed {
  final String name;
  final String origin;
  final String temperament;
  final String lifeSpan;
  final String weight;
  final String description;
  final List<String> images;

  CatBreed({
    required this.name,
    required this.origin,
    required this.temperament,
    required this.lifeSpan,
    required this.weight,
    required this.description,
    required this.images,
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
    'The British Shorthair is known for its dense coat, broad face, and stocky body. These cats are quiet and gentle, making them ideal companions. They are not typically lap cats but enjoy being near their humans and are very loyal.\n\nThey are independent but affectionate, get along well with children and other pets, and have a calm, dignified presence. The British Shorthair’s plush coat comes in many colors, but the "British Blue" (a solid grey-blue) is especially popular.',
    images: [
      'assets/images/british_shorthair_1.png',
      'assets/images/british_shorthair_2.png',
      'assets/images/british_shorthair_3.png',
    ],
  ),
];
