import 'package:flutter/material.dart';
import 'package:swagger_ruby_flutter_sample/models/book.dart';
import 'package:swagger_ruby_flutter_sample/screens/book_details_page.dart';

class BookListItem extends StatelessWidget {
  final Book book;

  const BookListItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            book.imageUrl,
            width: 50,
            height: 100,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.broken_image);
            },
          ),
        ),
        title: Text(book.title),
        subtitle: Text(book.publisher),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailsPage(book: book),
            ),
          );
        },
      ),
    );
  }
}
