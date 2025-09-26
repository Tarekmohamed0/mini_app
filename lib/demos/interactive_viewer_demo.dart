import 'package:flutter/material.dart';

class InteractiveViewerDemo extends StatefulWidget {
  const InteractiveViewerDemo({super.key});

  @override
  State<InteractiveViewerDemo> createState() => _InteractiveViewerDemoState();
}

class _InteractiveViewerDemoState extends State<InteractiveViewerDemo> {
  final TransformationController _controller = TransformationController();
  double _currentScale = 1.0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: InteractiveViewer(
            transformationController: _controller,
            boundaryMargin: const EdgeInsets.all(20),
            minScale: 0.5,
            maxScale: 4.0,
            onInteractionUpdate: (details) {
              setState(() {
                _currentScale = _controller.value.getMaxScaleOnAxis();
              });
            },
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  // Grid pattern
                  ...List.generate(25, (index) {
                    final i = index % 5;
                    final j = index ~/ 5;
                    return Positioned(
                      left: 60.0 * i + 20,
                      top: 60.0 * j + 20,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  // Center icon
                  const Center(
                    child: Icon(
                      Icons.zoom_in,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Scale: ${_currentScale.toStringAsFixed(2)}x'),
                  ElevatedButton(
                    onPressed: () {
                      _controller.value = Matrix4.identity();
                      setState(() {
                        _currentScale = 1.0;
                      });
                    },
                    child: const Text('Reset'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Pinch to zoom • Drag to pan',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}