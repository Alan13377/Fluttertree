import 'package:freezed_annotation/freezed_annotation.dart';

part "link.freezed.dart";

@freezed
class Linktree with _$Linktree {
  factory Linktree({
    required Map<String, dynamic> metadada,
    required Map<String, dynamic> sys,
    required Map<String, dynamic> fields,
  }) = _Linktreek;
}
