import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swagger_ruby_flutter_sample/providers/books_notifier.dart';
import '../models/book.dart';

class EditBookPage extends HookConsumerWidget {
  const EditBookPage({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController(text: book.title);
    final publisherController = TextEditingController(text: book.publisher);
    final descriptionController = TextEditingController(text: book.description);
    final pageCountController =
        TextEditingController(text: book.pageCount.toString());
    final imageUrlController = TextEditingController(text: book.imageUrl);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: publisherController,
                decoration: const InputDecoration(labelText: 'Publisher'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              TextField(
                controller: pageCountController,
                decoration: const InputDecoration(labelText: 'Page Count'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
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

                  final updatedBookData = {
                    "title": title,
                    "publisher": publisher,
                    "description": description,
                    "page_count": pageCount,
                    "image_url": imageUrl,
                  };

                  try {
                    await ref
                        .read(booksNotifierProvider.notifier)
                        .updateBook(book.id, updatedBookData);
                    if (context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Book updated successfully')),
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
                child: const Text('Update Book'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
