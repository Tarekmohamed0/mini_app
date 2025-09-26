import 'package:flutter/material.dart';

class WidgetInfo {
  final String name;
  final String description;
  final String category;
  final IconData icon;
  final List<String> features;
  final String difficulty;
  final Color color;

  const WidgetInfo({
    required this.name,
    required this.description,
    required this.category,
    required this.icon,
    required this.features,
    required this.difficulty,
    required this.color,
  });
}

class WidgetCatalogData {
  static List<WidgetInfo> get widgets => [
    const WidgetInfo(
      name: 'Backdrop',
      description: 'A material design backdrop widget that reveals content behind the front layer',
      category: 'Material Design',
      icon: Icons.layers,
      features: [
        'Front and back layer navigation',
        'Material Design compliant',
        'Smooth reveal animations',
        'Customizable header and content'
      ],
      difficulty: 'Intermediate',
      color: Colors.blue,
    ),
    const WidgetInfo(
      name: 'Stepper',
      description: 'A widget that displays progress through numbered steps with optional content',
      category: 'Navigation',
      icon: Icons.timeline,
      features: [
        'Horizontal and vertical layouts',
        'Step validation and control',
        'Custom step content',
        'Progress tracking'
      ],
      difficulty: 'Beginner',
      color: Colors.green,
    ),
    const WidgetInfo(
      name: 'ExpansionTile',
      description: 'A collapsible list item that can expand to show more content when tapped',
      category: 'Lists & Collections',
      icon: Icons.expand_more,
      features: [
        'Smooth expand/collapse animations',
        'Customizable leading and trailing widgets',
        'Nested expansion support',
        'Initial expanded state control'
      ],
      difficulty: 'Beginner',
      color: Colors.orange,
    ),
    const WidgetInfo(
      name: 'FractionallySizedBox',
      description: 'Sizes its child to a fraction of the available space',
      category: 'Layout',
      icon: Icons.aspect_ratio,
      features: [
        'Percentage-based sizing',
        'Responsive design helper',
        'Width and height factors',
        'Alignment control'
      ],
      difficulty: 'Beginner',
      color: Colors.purple,
    ),
    const WidgetInfo(
      name: 'Hero',
      description: 'Creates smooth shared element transitions between screens',
      category: 'Animation',
      icon: Icons.flight_takeoff,
      features: [
        'Shared element transitions',
        'Automatic animation handling',
        'Cross-screen animations',
        'Material Design transitions'
      ],
      difficulty: 'Intermediate',
      color: Colors.red,
    ),
    const WidgetInfo(
      name: 'InteractiveViewer',
      description: 'A widget that allows pan, zoom, and other interactive gestures',
      category: 'Interaction',
      icon: Icons.zoom_in,
      features: [
        'Pan and zoom interactions',
        'Boundary constraints',
        'Scale limits control',
        'Custom transformation handling'
      ],
      difficulty: 'Intermediate',
      color: Colors.teal,
    ),
  ];

  static List<String> get categories => [
    'All',
    'Material Design',
    'Navigation',
    'Lists & Collections',
    'Layout',
    'Animation',
    'Interaction',
  ];

  static List<String> get difficulties => [
    'All',
    'Beginner',
    'Intermediate',
    'Advanced',
  ];
}