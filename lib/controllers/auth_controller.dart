import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../services/auth_service.dart';
import 'package:shelf_router/shelf_router.dart';

class AuthController {
  final AuthService _service;

  final Router _router = Router();
  
  Router get router => _router;

  AuthController(this._service){
    _router.post('/auth/register', register);
    _router.post('/auth/login', login);
  }

  Future<Response> register(Request req) async{
    final body = await req.readAsString();
    final data = jsonDecode(body);

    final username = data['username'];
    final email = data['email'];
    final password = data['password'];

    if(username == null || email == null || password == null){
      return Response.badRequest(body: jsonEncode({'error': 'Todos os campos são obrigatórios'}));
    }

    final user = await _service.register(username, email, password);

    if(user == null){
      return Response.badRequest(body: jsonEncode({'error': 'Usuário já existe'}));
    }

    return Response.ok(
      jsonEncode({
        'id': user.id,
        'username': user.username,
        'email': user.email,
        'token': user.token
      }),
      headers: {'Content-Type': 'application/json'}
    );
  }

  Future<Response> login(Request req) async{
    final body = await req.readAsString();
    final data = jsonDecode(body);

    final username = data['username'];
    final password = data['password'];

    if(username == null || password == null){
      return Response.badRequest(body: jsonEncode({'error': 'Credenciais incompletas'}));
    }

    final user = await _service.login(username, password);

    if(user == null){
      return Response.unauthorized(
        jsonEncode({'error': 'Credenciais inválidas'}),
        headers: {'Content-Type': 'application/json'}
      );
    }

    return Response.ok(
      jsonEncode(user.toJson()),
      headers: {'Content-Type': 'application/json'}
    );
  }
}