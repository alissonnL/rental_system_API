import 'package:sqlite3/sqlite3.dart';

class DataBaseHelper{
  static final DataBaseHelper _instance = DataBaseHelper._internal();
  late Database db;

  factory DataBaseHelper() => _instance;

  DataBaseHelper._internal(){
    db = sqlite3.open('rental_system.db');
    _createTables();
  }

  void _createTables(){
    db.execute(
      ''' CREATE TABLE IF NOT EXISTS imoveis(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        endereco TEXT NOT NULL,
        valor REAL NOT NULL)'''
      );
  }
}