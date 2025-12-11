import 'package:sqlite3/sqlite3.dart';
import '../database/database.dart';

class UserRepository {
  final Database db = DataBaseHelper().db;

  Map<String, dynamic>? findUserWithPassword(String username){
    final result = db.select('SELECT id, username, email, password FROM users WHERE username = ?', [username]);
    if(result.isEmpty) return null;
    return result.first;
  }

  int create(String username, String email, String hashedPassword){
    db.execute(
      'INSERT INTO users (username, email, password) VALUES (?,?,?)',
      [username, email, hashedPassword]
    );
    return db.lastInsertRowId;
  }
}