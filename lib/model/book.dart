class Book {
  final String id;
  final String author;
  final String genre;
  final bool inStock;
  final String pages;
  final int price;
  final String publisher;
  final String title;

  Book(
      {required this.id,
      required this.author,
      required this.genre,
      required this.inStock,
      required this.pages,
      required this.price,
      required this.publisher,
      required this.title});
}
