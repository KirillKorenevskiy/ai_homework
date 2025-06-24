class CatBreed {
  final String id;
  final String name;
  final String? description;
  final String? temperament;
  final String? origin;
  final String? lifeSpan;
  final int? adaptability;
  final int? affectionLevel;
  final int? childFriendly;
  final int? dogFriendly;
  final int? energyLevel;
  final int? grooming;
  final int? healthIssues;
  final int? intelligence;
  final int? sheddingLevel;
  final int? socialNeeds;
  final int? strangerFriendly;
  final String? wikipediaUrl;
  final Map<String, dynamic>? weight;
  final Map<String, String>? image;

  CatBreed({
    required this.id,
    required this.name,
    this.description,
    this.temperament,
    this.origin,
    this.lifeSpan,
    this.adaptability,
    this.affectionLevel,
    this.childFriendly,
    this.dogFriendly,
    this.energyLevel,
    this.grooming,
    this.healthIssues,
    this.intelligence,
    this.sheddingLevel,
    this.socialNeeds,
    this.strangerFriendly,
    this.wikipediaUrl,
    this.weight,
    this.image,
  });

  factory CatBreed.fromJson(Map<String, dynamic> json) {
    return CatBreed(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      temperament: json['temperament'] as String?,
      origin: json['origin'] as String?,
      lifeSpan: json['life_span'] as String?,
      adaptability: json['adaptability'] as int?,
      affectionLevel: json['affection_level'] as int?,
      childFriendly: json['child_friendly'] as int?,
      dogFriendly: json['dog_friendly'] as int?,
      energyLevel: json['energy_level'] as int?,
      grooming: json['grooming'] as int?,
      healthIssues: json['health_issues'] as int?,
      intelligence: json['intelligence'] as int?,
      sheddingLevel: json['shedding_level'] as int?,
      socialNeeds: json['social_needs'] as int?,
      strangerFriendly: json['stranger_friendly'] as int?,
      wikipediaUrl: json['wikipedia_url'] as String?,
      weight: json['weight'] != null ? Map<String, dynamic>.from(json['weight'] as Map) : null,
      image: json['image'] != null ? Map<String, String>.from(json['image'] as Map) : null,
    );
  }

  String? get imageUrl => image?['url'];

  String get weightRange {
    if (weight == null) return 'N/A';
    return '${weight!['metric']} kg';
  }
}
