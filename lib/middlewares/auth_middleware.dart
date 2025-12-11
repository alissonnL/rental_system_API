import 'package:shelf/shelf.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'dart:convert';

const String _jwtSecret = 'ajkls';

Middleware authMiddleware() {
  return (Handler innerHandler) {
    return (Request request) async {
      if (request.url.pathSegments.contains('auth')) {
        return innerHandler(request);
      }

      final authHeader = request.headers['authorization'];

      if (authHeader == null || !authHeader.startsWith('Bearer ')) {
        return Response.unauthorized(
          jsonEncode({'error': 'Token de autorização ausente ou inválido'}),
          headers: {'Content-Type': 'application/json'},
        );
      }

      final token = authHeader.substring(7);

      try {
        final jwt = JWT.verify(token, SecretKey(_jwtSecret));

        final userId = jwt.payload['id'] as int;
        final updateRequest = request.change(context: {'userId': userId});

        return innerHandler(updateRequest);
      } on JWTException {
        return Response.unauthorized(
          jsonEncode({'error': 'Token inválido ou expirado'}),
          headers: {'Content-Type': 'application/json'},
        );
      }
    };
  };
}
