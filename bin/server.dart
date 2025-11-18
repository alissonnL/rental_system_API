import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

import '../lib/controllers/imovel_controller.dart';
import '../lib/services/imovel_service.dart';

void main() async {

  //camadas
  final service = ImovelService();
  final controller = ImovelController(service);

  final router = Router();

  router.mount('/', controller.router);

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router);

  final server = await io.serve(handler, InternetAddress.anyIPv4, 8080);

  print('✅ Servidor rodando em http://localhost:${server.port}');
}
