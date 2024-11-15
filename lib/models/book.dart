class Book {
  final int id;
  final String title;
  final String publisher;
  final String description;
  final int pageCount;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Book({
    required this.id,
    required this.title,
    required this.publisher,
    required this.description,
    required this.pageCount,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      publisher: json['publisher'],
      description: json['description'],
      pageCount: json['page_count'],
      imageUrl: json['image_url'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}