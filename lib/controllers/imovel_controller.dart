import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../services/imovel_service.dart';
import '../models/imovel.dart';

class ImovelController {
  final ImovelService service;
  final Router _router = Router();

  Router get router => _router;

  ImovelController(this.service) {
    _router.get('/properties', getAll);
    _router.get('/properties/<id>', getById);
    _router.post('/properties', create);
    _router.put('/properties/<id>', update);
    _router.delete('/properties/<id>', delete);
  }

  Future<Response> getAll(Request req) async {
    final imoveis = await service.getAll();
    final json = jsonEncode(imoveis.map((i) => i.toJson()).toList());
    return Response.ok(json, headers: {'Content-Type': 'application/json'});
  }

  Future<Response> getById(Request req, String id) async{
    final imovel = await service.getById(int.parse(id));
    if (imovel == null) {
      return Response.notFound(jsonEncode({'error': 'Imóvel não encontrado'}));
    }
    return Response.ok(
      jsonEncode(imovel.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<Response> create(Request req) async {
    final body = await req.readAsString();
    final data = jsonDecode(body);

    final novo = Imovel(
      endereco: (data['endereco'] ?? '').toString(),
      valor: (data['valor'] ?? 0).toDouble(),
    );

    service.create(novo);

    return Response.ok(
      jsonEncode({'message': 'Imóvel adicionado com sucesso'}),
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<Response> update(Request req, String id) async {
    final body = await req.readAsString();
    final data = jsonDecode(body);

    final imovelExistente = await service.getById(int.parse(id));
    if (imovelExistente == null) {
      return Response.notFound(jsonEncode({'error': 'Imóvel não encontrado'}));
    }

    final atualizado = Imovel(
      id: imovelExistente.id,
      endereco: (data['endereco'] ?? imovelExistente.endereco).toString(),
      valor: (data['valor'] ?? imovelExistente.valor).toDouble(),
    );

    final sucesso = await service.update(int.parse(id), atualizado);

    if (!sucesso) {
      return Response.internalServerError(
        body: jsonEncode({'error': 'Falha ao atualizar imóvel'}),
      );
    }

    return Response.ok(
      jsonEncode({'message': 'Imóvel atualizado com sucesso'}),
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<Response> delete(Request req, String id) async {
    final sucesso = await service.delete(int.parse(id));
    if (!sucesso) {
      return Response.notFound(jsonEncode({'error': 'Imóvel não encontrado'}));
    }

    return Response.ok(
      jsonEncode({'message': 'Imóvel removido com sucesso'}),
      headers: {'Content-Type': 'application/json'},
    );
  }
}
