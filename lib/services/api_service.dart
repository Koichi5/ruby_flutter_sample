import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/book.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<Book>> fetchBooks() async {
    final response = await http.get(Uri.parse('$baseUrl/books/index'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> booksJson = data['books'];
      return booksJson.map((json) => Book.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load books: ${response.statusCode}');
    }
  }

  Future<Book> addBook(Map<String, dynamic> bookData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/books/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(bookData),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Book.fromJson(data['book']);
    } else {
      throw Exception('Failed to add book: ${response.statusCode}');
    }
  }

  Future<Book> updateBook(int id, Map<String, dynamic> bookData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/books/update/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(bookData),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Book.fromJson(data['book']);
    } else {
      throw Exception('Failed to update book: ${response.statusCode}');
    }
  }

  Future<void> deleteBook(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/books/delete/$id'),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete book: ${response.statusCode}');
    }
  }
}