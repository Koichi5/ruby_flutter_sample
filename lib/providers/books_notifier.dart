import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:swagger_ruby_flutter_sample/providers/api_service_provider.dart';
import '../models/book.dart';
import '../services/api_service.dart';

part 'books_notifier.g.dart';

@riverpod
class BooksNotifier extends _$BooksNotifier {
  late final ApiService apiService;

  @override
  Future<List<Book>> build() async {
    apiService = ref.read(apiServiceProvider);
    return await apiService.fetchBooks();
  }

  Future<void> addBook(Map<String, dynamic> bookData) async {
    state = const AsyncValue.loading();
    try {
      final newBook = await apiService.addBook(bookData);
      final currentBooks = state.value ?? [];
      state = AsyncValue.data([...currentBooks, newBook]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateBook(int id, Map<String, dynamic> bookData) async {
    state = const AsyncValue.loading();
    try {
      final updatedBook = await apiService.updateBook(id, bookData);
      final currentBooks = state.value ?? [];
      final index = currentBooks.indexWhere((book) => book.id == id);
      if (index != -1) {
        currentBooks[index] = updatedBook;
        state = AsyncValue.data([...currentBooks]);
      } else {
        throw Exception('Book not found');
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteBook(int id) async {
    state = const AsyncValue.loading();
    try {
      await apiService.deleteBook(id);
      final currentBooks = state.value ?? [];
      currentBooks.removeWhere((book) => book.id == id);
      state = AsyncValue.data([...currentBooks]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}