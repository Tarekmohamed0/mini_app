import 'package:flutter/material.dart';
import '../data/widget_data.dart';
import '../demos/backdrop_demo.dart';
import '../demos/stepper_demo.dart';
import '../demos/expansion_tile_demo.dart';
import '../demos/fractionally_sized_box_demo.dart';
import '../demos/hero_demo.dart';
import '../demos/interactive_viewer_demo.dart';

class WidgetDetailScreen extends StatelessWidget {
  final WidgetInfo widget;

  const WidgetDetailScreen({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: widget.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            widget.icon,
                            color: widget.color,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.name,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  _buildChip(widget.category, Colors.blue),
                                  const SizedBox(width: 8),
                                  _buildChip(widget.difficulty, _getDifficultyColor(widget.difficulty)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Features Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Key Features',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...widget.features.map((feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: widget.color,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              feature,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Demo Section
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Interactive Demo',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(
                        minHeight: 200,
                        maxHeight: 400,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: _buildDemo(),
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
  }

  Widget _buildDemo() {
    switch (widget.name) {
      case 'Backdrop':
        return const BackdropDemo();
      case 'Stepper':
        return const StepperDemo();
      case 'ExpansionTile':
        return const ExpansionTileDemo();
      case 'FractionallySizedBox':
        return const FractionallySizedBoxDemo();
      case 'Hero':
        return const HeroDemo();
      case 'InteractiveViewer':
        return const InteractiveViewerDemo();
      default:
        return const Center(
          child: Text(
            'Demo coming soon...',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        );
    }
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Beginner':
        return Colors.green;
      case 'Intermediate':
        return Colors.orange;
      case 'Advanced':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}