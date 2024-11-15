import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swagger_ruby_flutter_sample/providers/books_notifier.dart';

class AddBookPage extends HookConsumerWidget {
  const AddBookPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final publisherController = TextEditingController();
    final descriptionController = TextEditingController();
    final pageCountController = TextEditingController();
    final imageUrlController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('本の追加'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'タイトル'),
              ),
              TextField(
                controller: publisherController,
                decoration: const InputDecoration(labelText: '出版社'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: '説明文'),
                maxLines: 3,
              ),
              TextField(
                controller: pageCountController,
                decoration: const InputDecoration(labelText: 'ページ数'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: imageUrlController,
                decoration: const InputDecoration(labelText: '書影画像URL'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final title = titleController.text.trim();
                  final publisher = publisherController.text.trim();
                  final description = descriptionController.text.trim();
                  final pageCount =
                      int.tryParse(pageCountController.text.trim()) ?? 0;
                  final imageUrl = imageUrlController.text.trim();

                  if (title.isEmpty ||
                      publisher.isEmpty ||
                      description.isEmpty ||
                      imageUrl.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('All fields are required')),
                    );
                    return;
                  }

                  final bookData = {
                    "title": title,
                    "publisher": publisher,
                    "description": description,
                    "page_count": pageCount,
                    "image_url": imageUrl,
                  };

                  try {
                    await ref
                        .read(booksNotifierProvider.notifier)
                        .addBook(bookData);
                    if (context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Book added successfully')),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $e')),
                      );
                    }
                  }
                },
                child: const Text('追加'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
