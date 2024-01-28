import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'clothing_item.dart';
import 'clothing_provider.dart';

class ClothingAddEditScreen extends StatefulWidget {
  final ClothingItem? editingItem;

  const ClothingAddEditScreen({Key? key, this.editingItem}) : super(key: key);

  @override
  _ClothingAddEditScreenState createState() => _ClothingAddEditScreenState();
}

class _ClothingAddEditScreenState extends State<ClothingAddEditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _colorController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.editingItem?.name ?? '');
    _colorController = TextEditingController(text: widget.editingItem?.color ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editingItem == null ? 'Додади нова облека' : 'Промени облека'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _colorController,
              decoration: const InputDecoration(
                labelText: "Боја",
                labelStyle: TextStyle(color: Colors.blue)
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                  labelText: 'Име',
                  labelStyle: TextStyle(color: Colors.blue)),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _saveItem(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green
              ),
              child: const Text('Зачувај', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  void _saveItem(BuildContext context) {
    final name = _nameController.text.trim();
    final color = _colorController.text.trim();

    if (name.isNotEmpty && color.isNotEmpty) {
      final newItem = ClothingItem(name: name, color: color);

      if (widget.editingItem == null) {
        Provider.of<ClothingProvider>(context, listen: false).addClothingItem(newItem);
      } else {
        Provider.of<ClothingProvider>(context, listen: false)
            .editClothingItem(Provider.of<ClothingProvider>(context, listen: false).clothingItems.indexOf(widget.editingItem!), newItem);
      }
      Navigator.pop(context);
    }
  }
}
