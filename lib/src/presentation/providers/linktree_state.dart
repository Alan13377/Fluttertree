import "package:freezed_annotation/freezed_annotation.dart";
import "package:linsk_bio/src/domain/failures/http_request_failures.dart";

part "linktree_state.freezed.dart";

@freezed
class LinktreeState with _$LinktreeState {
  const factory LinktreeState.loading() = _Loading;
  const factory LinktreeState.failed(HttpRequestFailure failure) = _Failed;
  const factory LinktreeState.loaded({
    required List linktrees,
  }) = _LinktreeState;
}
