import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riveplayer/utils/rive_assets.dart';

class ClientRiveScreen extends StatelessWidget {
  final String clientName;

  const ClientRiveScreen({super.key, required this.clientName});

  // List of Rive files available in assets
  static const List<String> riveFiles = [
    'test.riv',
    'test_another.riv',
  ];

  @override
  Widget build(BuildContext context) {
    final decodedClientName = Uri.decodeComponent(clientName);
    final files = RiveAssets.getClientFiles(decodedClientName);

    return Scaffold(
      appBar: AppBar(
        title: Text('$decodedClientName - Rive Files'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: files.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.folder_open, size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'No Rive files found for $decodedClientName',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                final fileName = files[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.play_circle_outline, size: 40),
                    title: Text(
                      fileName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      'Rive animation ${index + 1} of ${files.length}',
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Navigate to player screen with client name and file name
                      context.go(
                        '/player/${Uri.encodeComponent(decodedClientName)}/${Uri.encodeComponent(fileName)}',
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
