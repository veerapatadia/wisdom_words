class Quotes {
  String quotes;
  String author;
  String categoryName;

  Quotes(
      {required this.quotes, required this.author, required this.categoryName});

  factory Quotes.frommap({required Map<String, dynamic> info}) {
    return Quotes(
        quotes: info['quotes'],
        author: info['author'],
        categoryName: info['categoryName']);
  }
}
