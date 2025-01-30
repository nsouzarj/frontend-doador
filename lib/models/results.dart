class ObesityPercentage {
  final double masculino;
  final double feminino;

  ObesityPercentage({required this.masculino, required this.feminino});

  factory ObesityPercentage.fromJson(Map<String, dynamic> json) {
    return ObesityPercentage(
      masculino: _safeParseDouble(json['Masculino']),
      feminino: _safeParseDouble(json['Feminino']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Masculino': masculino,
      'Feminino': feminino,
    };
  }
  static double _safeParseDouble(dynamic value) {
    if (value == null) {
      return 0.0; // Retorna 0.0 se for null
    }
    if(value is double) {
      return value;
    }
    if(value is int) {
      return value.toDouble();
    }
    if(value is String) {
      return double.tryParse(value) ?? 0.0;
    }
    return 0.0;
  }
}