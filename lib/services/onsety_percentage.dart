// Exemplo de Model ObesityPercentage
class ObesityPercentage {
  final double masculino;
  final double feminino;

  ObesityPercentage({required this.masculino, required this.feminino});

  factory ObesityPercentage.fromJson(Map<String, dynamic> json) {
    return ObesityPercentage(
      masculino: (json['Masculino'] as num).toDouble(),
      feminino: (json['Feminino'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Masculino': masculino,
      'Feminino': feminino,
    };
  }
}