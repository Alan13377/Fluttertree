import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:linsk_bio/src/data/repository_impl/linktree_repository_impl.dart';
import 'package:linsk_bio/src/data/services/api_services.dart';
import 'package:linsk_bio/src/domain/either/either.dart';
import 'package:linsk_bio/src/domain/failures/http_request_failures.dart';
import 'package:linsk_bio/src/domain/models/link.dart';

typedef GetLinksFuture = Future<Either<HttpRequestFailure, List<Linktree>>>;

abstract class LinktreeRepository {
  GetLinksFuture getLinks();
}

final linktreeRepository = Provider(
  (ref) => LinktreeRepositoryImpl(
    ApiServices(
      client: Client(),
    ),
  ),
);
