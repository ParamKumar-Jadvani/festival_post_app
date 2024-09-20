class FestivalModel {
  final String name;
  final String date;
  final String description;
  final String thumbnail;
  final List<String> images;
  final List<String> quotes;
  final String slogan;

  FestivalModel({
    required this.name,
    required this.date,
    required this.description,
    required this.thumbnail,
    required this.images,
    required this.quotes,
    required this.slogan,
  });

  factory FestivalModel.fromMap(Map<String, dynamic> festival) {
    return FestivalModel(
      name: festival['name'],
      date: festival['date'],
      description: festival['description'],
      thumbnail: festival['thumbnail'],
      images: List<String>.from(festival['images']),
      quotes: List<String>.from(festival['quotes']),
      slogan: festival['slogan'],
    );
  }
}
