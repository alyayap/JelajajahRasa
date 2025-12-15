class Place {
  final int placeId;
  final String name;
  final String category;
  final String imageUrl;
  final double rating;
  final int avgPrice;

  Place({
    required this.placeId,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.rating,
    required this.avgPrice,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      placeId: json['place_id'],
      name: json['name'],
      category: json['category'],
      imageUrl: json['image_url'],
      rating: double.parse(json['rating'].toString()),
      avgPrice: json['avg_price'],
    );
  }
}
