import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'clothing_provider.dart';
import 'clothing_item.dart';
import 'clothing_add_edit_screen.dart';

class ClothingListScreen extends StatelessWidget {
  const ClothingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ClothingItem> clothingItems = context.watch<ClothingProvider>().clothingItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Листа со облека'),
      ),
      body: ListView.builder(
        itemCount: clothingItems.length,
        itemBuilder: (context, index) {
          ClothingItem item = clothingItems[index];
          return ListTile(
            title: Text("${item.color} ${item.name}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _navigateToEditScreen(context, item);
                  },
                  color: Colors.green
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _showDeleteConfirmationDialog(context, index);
                  },
                  color: Colors.green
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddScreen(context);
        },
        backgroundColor: Colors.greenAccent,
        foregroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToAddScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ClothingAddEditScreen()),
    );
  }

  void _navigateToEditScreen(BuildContext context, ClothingItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClothingAddEditScreen(editingItem: item)),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Избриши'),
          content: const Text('Дали сте сигурни дека сакате да го избришете ова?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white
              ),
              child: const Text('Не'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<ClothingProvider>(context, listen: false).removeClothingItem(index);
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green
              ),
              child: const Text('Да'),
            ),
          ],
        );
      },
    );
  }
}
