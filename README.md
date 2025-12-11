Rental System – Backend (Dart)

Backend do sistema de aluguel desenvolvido em Dart, usando Shelf, SQLite e autenticação JWT. Estruturado em camadas para facilitar manutenção e expansão.

🚀 Tecnologias
Dart
Shelf / Shelf Router
SQLite
JWT

▶️ Executando
dart pub get
dart run bin/server.dart


Servidor padrão: http://localhost:8080

🔐 Autenticação

Após login, inclua o token nas requisições:

Authorization: Bearer SEU_TOKEN

📌 Endpoints
Autenticação
POST /login
POST /register

Imóveis (protegidos)
GET /imoveis
GET /imoveis/:id
POST /imoveis
PUT /imoveis/:id
DELETE /imoveis/:id
