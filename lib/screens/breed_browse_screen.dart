import 'package:flutter/material.dart';
import '../data/breeds.dart';

class BreedBrowseScreen extends StatefulWidget {
  final Function(int) onSwipe;

  const BreedBrowseScreen({
    super.key,
    required this.onSwipe,
  });

  @override
  _BreedBrowseScreenState createState() => _BreedBrowseScreenState();
}

class _BreedBrowseScreenState extends State<BreedBrowseScreen> {
  late final PageController controller;
  late final List<CatBreed> sortedBreeds;
  static const int _virtualItemCount = 10000;

  @override
  void initState() {
    super.initState();
    sortedBreeds = List.of(breeds)..sort((a, b) => a.name.compareTo(b.name));
    controller = PageController(initialPage: _virtualItemCount ~/ 2);
  }

  int _getRealIndex(int position) {
    return position % sortedBreeds.length;
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      itemCount: _virtualItemCount,
      onPageChanged: (index) {
        final realIndex = _getRealIndex(index);
        widget.onSwipe(realIndex);
      },
      itemBuilder: (context, index) {
        final realIndex = _getRealIndex(index);
        final breed = sortedBreeds[realIndex];

        return Stack(
          children: [
            Container(
              color: const Color.fromRGBO(247, 241, 228, 1),
              child: Center(
                child: Image.asset(
                  breed.images.first,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            const Positioned(
              top: 0,
              left: 40,
              right: 0,
              child: SafeArea(
                child: Text(
                  'The Cats',
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'AbrilFatface',
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom + 40),
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Text(
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
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}