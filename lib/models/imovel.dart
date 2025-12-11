class Imovel {
  final int? id;
  final String endereco;
  final double valor;
  final int userId;

  Imovel({this.id, required this.endereco, required this.valor, required this.userId});

  factory Imovel.fromJson(Map<String, dynamic> json) {
    return Imovel(
      id: json['id'],
      endereco: json['endereco'],
      valor: (json['valor'] as num).toDouble(),
      userId: json['userId'] as int
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'endereco': endereco,
      'valor': valor,
      'userId': userId
    };
  }
}