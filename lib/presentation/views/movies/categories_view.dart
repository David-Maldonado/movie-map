import 'package:flutter/material.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vista de categorias'),
      ),
      body: const Center(
        child: Text('Categorías'),
      ),
    );
  }
}
