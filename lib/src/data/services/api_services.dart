import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:linsk_bio/src/domain/either/either.dart';
import 'package:linsk_bio/src/domain/failures/http_request_failures.dart';
import 'package:linsk_bio/src/domain/models/link.dart';
import 'package:linsk_bio/src/domain/repositories/linktree_repository.dart';

class ApiServices {
  final Client client;

  ApiServices({required this.client});

  GetLinksFuture getLinks() async {
    try {
      final response = await client.get(
        Uri.parse(
          "https://cdn.contentful.com/spaces/3e7fvkqvxq4k/environments/master/entries?access_token=1a1tP9YLVzoJSoOHudsMYa7uTO3nlZYNDxn0hThBKjI",
        ),
      );
      //print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["items"];

        final links = (data as List).map(
          (e) => Linktree(
            metadada: e["metadata"],
            sys: e["sys"],
            fields: e["fields"],
          ),
        );

        return Either.right(links.toList());
      }
      if (response.statusCode == 404) {
        throw HttpRequestFailure.notFound();
      }
      if (response.statusCode >= 500) {
        throw HttpRequestFailure.server();
      }
      throw HttpRequestFailure.local();
    } catch (e) {
      late HttpRequestFailure failure;
      if (e is HttpRequestFailure) {
        failure = e;
      } else if (e is SocketException || e is ClientException) {
        //*Errores por conexion
        failure = HttpRequestFailure.network();
      } else {
        failure = HttpRequestFailure.local();
      }
      return Either.left(failure);
    }
  }
}
