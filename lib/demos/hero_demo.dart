import 'package:flutter/material.dart';

class HeroDemo extends StatefulWidget {
  const HeroDemo({super.key});

  @override
  State<HeroDemo> createState() => _HeroDemoState();
}

class _HeroDemoState extends State<HeroDemo> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Hero(
            tag: 'hero-demo',
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isExpanded ? 200 : 100,
              height: isExpanded ? 200 : 100,
              decoration: BoxDecoration(
                color: isExpanded ? Colors.red : Colors.blue,
                borderRadius: BorderRadius.circular(isExpanded ? 20 : 50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: isExpanded ? 20 : 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(
                isExpanded ? Icons.close : Icons.flight_takeoff,
                color: Colors.white,
                size: isExpanded ? 40 : 30,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          isExpanded ? 'Tap to shrink' : 'Tap to expand',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HeroDestinationScreen(),
              ),
            );
          },
          child: const Text('Navigate with Hero'),
        ),
      ],
    );
  }
}

class HeroDestinationScreen extends StatelessWidget {
  const HeroDestinationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero Destination'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'hero-demo',
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(75),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Hero Animation Complete!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'The widget smoothly animated\nfrom the previous screen',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}