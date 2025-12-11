import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import '../repositories/user_repository.dart';
import '../models/user.dart';

const String _jwtSecret = 'ajkls';

class AuthService {
  final UserRepository _repository = UserRepository();

  String _hashPassword(String password){
    return 'hashed_$password';
  }

  bool _verifyPassword(String rawPassword, String hashedPassword){
    return 'hashed_$rawPassword' == hashedPassword;
  }

  String generateToken(int userId, String username){
    final jwt = JWT({'id': userId, 'username': username});
    return jwt.sign(SecretKey(_jwtSecret));
  }

  //---------------------------------------------------------------------------------

  Future<User?> register(String username, String email, String password) async{
    if(_repository.findUserWithPassword(username) != null) return null;

    final hashedPassword = _hashPassword(password);
    final newId = _repository.create(username, email, hashedPassword);
    
    final token = generateToken(newId, username);
    return User(id: newId, username: username, email: email, token: token);
  }
  
  Future<User?> login(String username, String password) async{
    final userData = _repository.findUserWithPassword(username);

    if(userData == null || !_verifyPassword(password, userData['password'])){
      return null;
    }

    final int userId = userData['id'];
    final String email = userData['email'];
    final token = generateToken(userId, username);

    return User(id: userId, username: username, email: email, token: token);
  }
}