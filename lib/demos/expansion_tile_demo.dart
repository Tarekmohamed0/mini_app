import 'package:flutter/material.dart';

class ExpansionTileDemo extends StatefulWidget {
  const ExpansionTileDemo({super.key});

  @override
  State<ExpansionTileDemo> createState() => _ExpansionTileDemoState();
}

class _ExpansionTileDemoState extends State<ExpansionTileDemo> {
  bool isExpanded1 = false;
  bool isExpanded2 = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ExpansionTile(
          leading: const Icon(Icons.folder, color: Colors.blue),
          title: const Text('Documents'),
          subtitle: const Text('3 files'),
          trailing: Icon(
            isExpanded1 ? Icons.expand_less : Icons.expand_more,
            color: Colors.grey,
          ),
          onExpansionChanged: (expanded) {
            setState(() {
              isExpanded1 = expanded;
            });
          },
          children: [
            ListTile(
              leading: const Icon(Icons.description, color: Colors.orange),
              title: const Text('Report.pdf'),
              subtitle: const Text('2.4 MB'),
              trailing: IconButton(
                icon: const Icon(Icons.download),
                onPressed: () {},
              ),
            ),
            ListTile(
              leading: const Icon(Icons.image, color: Colors.green),
              title: const Text('Photo.jpg'),
              subtitle: const Text('1.8 MB'),
              trailing: IconButton(
                icon: const Icon(Icons.download),
                onPressed: () {},
              ),
            ),
            ListTile(
              leading: const Icon(Icons.video_file, color: Colors.red),
              title: const Text('Video.mp4'),
              subtitle: const Text('15.2 MB'),
              trailing: IconButton(
                icon: const Icon(Icons.download),
                onPressed: () {},
              ),
            ),
          ],
        ),
        ExpansionTile(
          leading: const Icon(Icons.settings, color: Colors.grey),
          title: const Text('Settings'),
          subtitle: const Text('App preferences'),
          trailing: Icon(
            isExpanded2 ? Icons.expand_less : Icons.expand_more,
            color: Colors.grey,
          ),
          onExpansionChanged: (expanded) {
            setState(() {
              isExpanded2 = expanded;
            });
          },
          children: [
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              trailing: Switch(
                value: true,
                onChanged: (value) {},
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: false,
                onChanged: (value) {},
              ),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              subtitle: const Text('English'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          ],
        ),
        const ExpansionTile(
          leading: Icon(Icons.info, color: Colors.blue),
          title: Text('About'),
          subtitle: Text('App information'),
          children: [
            ListTile(
              title: Text('Version'),
              subtitle: Text('1.0.0'),
            ),
            ListTile(
              title: Text('Build Number'),
              subtitle: Text('100'),
            ),
            ListTile(
              title: Text('Developer'),
              subtitle: Text('Flutter Team'),
            ),
          ],
        ),
      ],
    );
  }
}