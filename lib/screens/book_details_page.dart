import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swagger_ruby_flutter_sample/providers/books_notifier.dart';
import 'package:swagger_ruby_flutter_sample/screens/edit_book_page.dart';
import '../models/book.dart';

class BookDetailsPage extends HookConsumerWidget {
  const BookDetailsPage({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('本の詳細'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.black54,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditBookPage(book: book),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.black54,
            ),
            onPressed: () {
              _confirmDelete(context, ref, book.id);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                child: Text(
                  book.title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                child: Image.network(
                  book.imageUrl,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 200);
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(
                    Icons.apartment,
                    color: Colors.black54,
                  ),
                    const SizedBox(width: 8),
                  Text(
                    book.publisher,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.book,
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${book.pageCount}ページ',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(book.description),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, int bookId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('本の削除'),
          content: const Text('本当に削除しますか？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('キャンセル'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await ref
                      .read(booksNotifierProvider.notifier)
                      .deleteBook(bookId);
                  if (context.mounted) {
                    Navigator.pop(context); // ダイアログを閉じる
                    Navigator.pop(context); // 詳細画面を閉じる
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Book deleted successfully')),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $e')),
                    );
                  }
                }
              },
              child: const Text('削除'),
            ),
          ],
        );
      },
    );
  }
}
