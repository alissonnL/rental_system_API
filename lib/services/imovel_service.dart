import '../models/imovel.dart';
import '../repositories/imovel_repository.dart';

class ImovelService {
  final ImovelRepository repository = ImovelRepository();

  Future<List<Imovel>> getAll() async {
    return repository.getAll();
  }

  Future<Imovel?> getById(int id) async {
    return repository.getById(id);
  }

  Future<void> create(Imovel imovel) async {
    repository.create(imovel);
  }

  Future<bool> update(int id, Imovel imovel) async {
    return repository.update(imovel);
  }

  Future<bool> delete(int id) async {
    return repository.delete(id);
  }
}
