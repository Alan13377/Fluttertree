import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linsk_bio/src/domain/repositories/linktree_repository.dart';
import 'package:linsk_bio/src/presentation/providers/linktree_state.dart';

final linktreesProvider =
    StateNotifierProvider<LinktreeProvider, LinktreeState>((ref) {
  final provider = ref.watch(linktreeRepository);
  return LinktreeProvider(provider);
});

class LinktreeProvider extends StateNotifier<LinktreeState> {
  final LinktreeRepository linktreeRepository;

  LinktreeProvider(this.linktreeRepository)
      : super(const LinktreeState.loading()) {
    loadLinks();
  }

  loadLinks() async {
    final linktreeList = await linktreeRepository.getLinks();

    linktreeList.when(left: (failure) {
      state = LinktreeState.failed(failure);
    }, right: (linktree) {
      state = LinktreeState.loaded(
        linktrees: linktree,
      );
    });
  }
}
