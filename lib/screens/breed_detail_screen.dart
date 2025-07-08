import 'package:flutter/material.dart';
import '../data/breeds.dart';

class BreedDetailScreen extends StatefulWidget {
  final int initialIndex;

  const BreedDetailScreen({super.key, required this.initialIndex});

  @override
  State<BreedDetailScreen> createState() => _BreedDetailScreenState();
}

class _BreedDetailScreenState extends State<BreedDetailScreen> {
  late PageController _horizontalController;
  late ScrollController _scrollController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _horizontalController = PageController(initialPage: currentIndex);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _horizontalController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final breed = breeds[currentIndex];

    return Scaffold(
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (_) => true,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.5,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(breed.name),
                  background: PageView.builder(
                    controller: _horizontalController,
                    itemCount: breed.images.length,
                    onPageChanged: (index) {
                      setState(() => currentIndex = index);
                    },
                    itemBuilder: (context, index) {
                      return Image.asset(
                        breed.images[index],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    breed.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      fontFamily: 'RobotoSlab',
                      fontWeight: FontWeight.w300,
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
}