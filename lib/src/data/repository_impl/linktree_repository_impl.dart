import 'package:linsk_bio/src/data/services/api_services.dart';
import 'package:linsk_bio/src/domain/repositories/linktree_repository.dart';

class LinktreeRepositoryImpl extends LinktreeRepository {
  final ApiServices _api;

  LinktreeRepositoryImpl(this._api);
  @override
  getLinks() {
    return _api.getLinks();
  }
}
