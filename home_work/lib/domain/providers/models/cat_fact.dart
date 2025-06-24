class CatFact {
  final String fact;
  final int length;

  CatFact({
    required this.fact,
    required this.length,
  });

  factory CatFact.fromJson(Map<String, dynamic> json) {
    return CatFact(
      fact: json['fact'] as String,
      length: json['length'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fact': fact,
      'length': length,
    };
  }
}
