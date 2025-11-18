class Imovel {
  final int? id;
  final String endereco;
  final double valor;

  Imovel({this.id, required this.endereco, required this.valor});

  factory Imovel.fromJson(Map<String, dynamic> json) {
    return Imovel(
      id: json['id'],
      endereco: json['endereco'],
      valor: (json['valor'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'endereco': endereco,
      'valor': valor
    };
  }
}