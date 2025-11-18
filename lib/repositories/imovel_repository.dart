import 'package:sqlite3/sqlite3.dart';
import '../models/imovel.dart';
import '../database/database.dart';

class ImovelRepository {
  final Database db = DataBaseHelper().db;

  List<Imovel> getAll() {
    final result = db.select('SELECT * FROM imoveis');
    return result.map((row) {
      return Imovel(
        id: row['id'] as int,
        endereco: row['endereco'] as String,
        valor: (row['valor'] as num).toDouble(),
      );
    }).toList();
  }

  Imovel? getById(int id) {
    final result = db.select('SELECT * FROM imoveis WHERE id = ?', [id]);
    if (result.isEmpty) return null;

    final row = result.first;
    return Imovel(
      id: row['id'] as int,
      endereco: row['endereco'] as String,
      valor: (row['valor'] as num).toDouble(),
    );
  }

  void create(Imovel imovel) {
    db.execute('INSERT INTO imoveis (endereco, valor) VALUES (?, ?)', [
      imovel.endereco,
      imovel.valor,
    ]);
  }

  bool update(Imovel imovel) {
    db.execute('UPDATE imoveis SET endereco = ?, valor = ? WHERE id = ?', [
      imovel.endereco,
      imovel.valor,
      imovel.id,
    ]);

    final check = db.select('SELECT id FROM imoveis WHERE id = ?', [imovel.id]);
    return check.isNotEmpty;
  }

  bool delete(int id) {
    db.execute('DELETE FROM imoveis WHERE id = ?', [id]);

    // Verifica se o registro ainda existe
    final check = db.select('SELECT id FROM imoveis WHERE id = ?', [id]);
    return check.isEmpty;
  }
}
