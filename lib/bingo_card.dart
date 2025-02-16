class BingoCard {
  final String image;
  final String title;
  final bool taped;

  BingoCard({
    required this.image,
    required this.title,
    required this.taped,
  });

  BingoCard copyWith({
    String? image,
    String? title,
    bool? taped,
  }) {
    return BingoCard(
      image: image ?? this.image,
      title: title ?? this.title,
      taped: taped ?? this.taped,
    );
  }
}
