class ValidadorImovel {
  static List<String> validar(Map<String, dynamic> data){
    List<String> erros = [];

    if(
        data['endereco'] == null ||
        data['endereco'] is !String ||
        data['endereco'].toString().trim().isEmpty
    ){
      erros.add('O campo "endereco" é obrigatório e deve ser uma string.');
    }

    if(data['valor'] == null){
      erros.add('O campo "valor" é obrigatório.');
    }else{
      final valor = double.tryParse(data['valor'].toString());
      if(valor == null || valor <= 0){
        erros.add('O campo "valor" deve ser um número positivo.');
      }
    }

    return erros;
  }
}