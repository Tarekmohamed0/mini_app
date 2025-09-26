import 'package:flutter/material.dart';

class FractionallySizedBoxDemo extends StatefulWidget {
  const FractionallySizedBoxDemo({super.key});

  @override
  State<FractionallySizedBoxDemo> createState() => _FractionallySizedBoxDemoState();
}

class _FractionallySizedBoxDemoState extends State<FractionallySizedBoxDemo> {
  double widthFactor = 0.5;
  double heightFactor = 0.3;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.grey[200],
            child: Stack(
              children: [
                // Grid lines for reference
                CustomPaint(
                  size: const Size.fromHeight(400),
                  painter: GridPainter(),
                ),
                // FractionallySizedBox demo
                FractionallySizedBox(
                  widthFactor: widthFactor,
                  heightFactor: heightFactor,
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${(widthFactor * 100).toInt()}% × ${(heightFactor * 100).toInt()}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            children: [
              Row(
                children: [
                  const Text('Width: '),
                  Expanded(
                    child: Slider(
                      value: widthFactor,
                      min: 0.1,
                      max: 1.0,
                      divisions: 9,
                      label: '${(widthFactor * 100).toInt()}%',
                      onChanged: (value) {
                        setState(() {
                          widthFactor = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('Height: '),
                  Expanded(
                    child: Slider(
                      value: heightFactor,
                      min: 0.1,
                      max: 1.0,
                      divisions: 9,
                      label: '${(heightFactor * 100).toInt()}%',
                      onChanged: (value) {
                        setState(() {
                          heightFactor = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 1;

    // Draw vertical lines
    for (int i = 1; i <= 10; i++) {
      final x = size.width * (i / 10);
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Draw horizontal lines
    for (int i = 1; i <= 10; i++) {
      final y = size.height * (i / 10);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}