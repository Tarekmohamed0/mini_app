import 'package:flutter/material.dart';

class BackdropDemo extends StatefulWidget {
  const BackdropDemo({super.key});

  @override
  State<BackdropDemo> createState() => _BackdropDemoState();
}

class _BackdropDemoState extends State<BackdropDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isBackdropOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleBackdrop() {
    setState(() {
      _isBackdropOpen = !_isBackdropOpen;
      if (_isBackdropOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Back layer
        Container(
          color: Colors.blue[100],
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.settings, size: 40, color: Colors.blue),
                SizedBox(height: 8),
                Text(
                  'Back Layer Content',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Hidden content revealed',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Front layer
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, 60 * _animation.value),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    // Header
                    GestureDetector(
                      onTap: _toggleBackdrop,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(16),
                            topRight: const Radius.circular(16),
                            bottomLeft: Radius.circular(_isBackdropOpen ? 0 : 16),
                            bottomRight: Radius.circular(_isBackdropOpen ? 0 : 16),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.menu, color: Colors.white),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'Backdrop Demo',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            AnimatedRotation(
                              turns: _isBackdropOpen ? 0.5 : 0,
                              duration: const Duration(milliseconds: 300),
                              child: const Icon(Icons.expand_more, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Content
                    if (!_isBackdropOpen)
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.layers, size: 40, color: Colors.grey),
                              SizedBox(height: 12),
                              Text(
                                'Front Layer Content',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Tap the header to reveal the back layer',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}