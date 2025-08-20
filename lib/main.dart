import 'package:flutter/material.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const TheCatsApp());
}

class TheCatsApp extends StatelessWidget {
  const TheCatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Cats',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(247, 241, 228, 1),
        fontFamily: 'RobotoSlab',
        primarySwatch: Colors.orange,
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}
