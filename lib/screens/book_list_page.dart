import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swagger_ruby_flutter_sample/providers/books_notifier.dart';
import 'package:swagger_ruby_flutter_sample/screens/components/book_list_item.dart';
import 'add_book_page.dart';

class BookListPage extends HookConsumerWidget {
  const BookListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsyncValue = ref.watch(booksNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('本の一覧'),
      ),
      body: booksAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (books) {
          if (books.isEmpty) {
            return const Center(child: Text('本が見つかりません'));
          }
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return BookListItem(book: book);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddBookPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
