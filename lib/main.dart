import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swagger_ruby_flutter_sample/screens/book_list_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Books List with Riverpod & GoRouter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BookListPage(),
    );
  }
}
