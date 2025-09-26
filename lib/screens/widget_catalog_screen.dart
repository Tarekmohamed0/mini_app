import 'package:flutter/material.dart';
import '../data/widget_data.dart';
import 'widget_detail_screen.dart';

class WidgetCatalogScreen extends StatefulWidget {
  const WidgetCatalogScreen({super.key});

  @override
  State<WidgetCatalogScreen> createState() => _WidgetCatalogScreenState();
}

class _WidgetCatalogScreenState extends State<WidgetCatalogScreen> {
  String selectedCategory = 'All';
  String selectedDifficulty = 'All';
  String searchQuery = '';

  List<WidgetInfo> get filteredWidgets {
    return WidgetCatalogData.widgets.where((widget) {
      final matchesCategory = selectedCategory == 'All' || widget.category == selectedCategory;
      final matchesDifficulty = selectedDifficulty == 'All' || widget.difficulty == selectedDifficulty;
      final matchesSearch = searchQuery.isEmpty || 
          widget.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          widget.description.toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesCategory && matchesDifficulty && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final widgets = filteredWidgets;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Widget Catalog'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: TextField(
              onChanged: (value) => setState(() => searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Search widgets...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Filters
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildFilterDropdown(
                        'Category',
                        selectedCategory,
                        WidgetCatalogData.categories,
                        (value) => setState(() => selectedCategory = value!),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildFilterDropdown(
                        'Difficulty',
                        selectedDifficulty,
                        WidgetCatalogData.difficulties,
                        (value) => setState(() => selectedDifficulty = value!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widgets.length} widget${widgets.length != 1 ? 's' : ''} found',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    if (selectedCategory != 'All' || selectedDifficulty != 'All' || searchQuery.isNotEmpty)
                      TextButton(
                        onPressed: () => setState(() {
                          selectedCategory = 'All';
                          selectedDifficulty = 'All';
                          searchQuery = '';
                        }),
                        child: const Text('Clear Filters'),
                      ),
                  ],
                ),
              ],
            ),
          ),
          
          // Widget List
          Expanded(
            child: widgets.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.widgets, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'No widgets found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Try adjusting your filters',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: widgets.length,
                    itemBuilder: (context, index) {
                      final widget = widgets[index];
                      return _buildWidgetCard(widget);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(
    String label,
    String value,
    List<String> items,
    void Function(String?) onChanged,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          onChanged: onChanged,
          isExpanded: true,
          hint: Text(label),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildWidgetCard(WidgetInfo widget) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WidgetDetailScreen(widget: widget),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: widget.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        widget.icon,
                        color: widget.color,
                        size: 24,
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
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
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
                    const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  widget.description,
                  style: TextStyle(
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: widget.features.take(2).map((feature) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        feature,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w500,
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