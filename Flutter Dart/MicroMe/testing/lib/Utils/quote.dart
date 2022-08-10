class Quote {
  late String text;
  late String author;

  Quote({
    required this.text,
    required this.author,
  });

  // Populates instance of quote class with json data
  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      text: json['text'],
      author: json['author'] ,
    );
  }
}
