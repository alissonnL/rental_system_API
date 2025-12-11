import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

import '../lib/controllers/imovel_controller.dart';
import '../lib/services/imovel_service.dart';
import '../lib/controllers/auth_controller.dart';
import '../lib/services/auth_service.dart';
import '../lib/middlewares/auth_middleware.dart';


void main() async {

  //camadas
  final imovelService = ImovelService();
  final imovelController = ImovelController(imovelService);

  final authService = AuthService();
  final authController = AuthController(authService);

  final router = Router();

  router.mount('/', imovelController.router);
  router.mount('/', authController.router);

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(authMiddleware())
      .addHandler(router);

  final server = await io.serve(handler, InternetAddress.anyIPv4, 8080);

  print('✅ Servidor rodando em http://localhost:${server.port}');
}
