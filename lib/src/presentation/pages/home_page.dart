import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linsk_bio/src/domain/models/link.dart';
import 'package:linsk_bio/src/presentation/providers/linktree_provider.dart';
import 'package:linsk_bio/src/presentation/widgets/customLink.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(linktreesProvider);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    double top = 0.0;

    return Scaffold(
      body: provider.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        failed: (failed) => Text(failed.toString()),
        loaded: (linktrees) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: [
                SliverAppBar(
                  pinned: true,
                  leading: IconButton(
                    onPressed: () async {
                      final link = await FlutterClipboard.copy(
                              "https://blogalan.netlify.app/")
                          .then(
                        (value) => const SnackBar(
                          content: Text("Link Copiado "),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(link);
                    },
                    icon: const Icon(
                      Icons.copy,
                      size: 35,
                    ),
                    color: scheme.onSecondaryContainer,
                  ),
                  actions: [
                    IconButton(
                      onPressed: () async {
                        String email = "alangustavo85@outlook.es";
                        String subject = "Saludos Alan";
                        String emailUrl = "mailto:$email?subject=$subject";
                        if (await canLaunchUrl(Uri.parse(emailUrl))) {
                          await launchUrl(
                            Uri.parse(emailUrl),
                          );
                        } else {
                          throw "Error occured sending an email";
                        }
                      },
                      icon: const Icon(
                        Icons.send,
                        size: 35,
                      ),
                      color: scheme.onSecondaryContainer,
                    )
                  ],
                  expandedHeight: 220,
                  flexibleSpace: LayoutBuilder(
                    builder: (context, constrains) {
                      top = constrains.biggest.height;
                      return CustomFlexibleApp(top: top);
                    },
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FittedBox(
                          child: AnimatedTextKit(
                            isRepeatingAnimation: false,
                            animatedTexts: [
                              TypewriterAnimatedText(
                                "Alan Gustavo Romero García",
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: scheme.primary,
                                ),
                                speed: const Duration(
                                  milliseconds: 100,
                                ),
                              ),
                            ],
                          ),
                        ),
                        FittedBox(
                          child: AnimatedTextKit(
                            isRepeatingAnimation: false,
                            animatedTexts: [
                              TypewriterAnimatedText(
                                "Desarrollador Flutter",
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: scheme.primary,
                                    overflow: TextOverflow.fade),
                                speed: const Duration(
                                  milliseconds: 100,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      primary: false,
                      shrinkWrap: true,
                      itemCount: linktrees.length,
                      itemBuilder: (context, index) {
                        final Linktree links = linktrees[index];
                        return Column(
                          children: [
                            CustomLink(
                              icon: links.fields["icono"],
                              link: links.fields["titulo"],
                              url: links.fields["url"],
                            ),
                          ],
                        );
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

//**APPBAR COLAPSADO */

class CustomFlexibleApp extends StatelessWidget {
  const CustomFlexibleApp({
    super.key,
    required this.top,
  });

  final double top;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      centerTitle: true,
      title: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: top <= 130 ? 1.0 : 0.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            CircleAvatar(
              child: Image.network(
                "https://cdn-icons-png.flaticon.com/512/1946/1946429.png",
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      background: Center(
        child: CircleAvatar(
          radius: 50,
          child: Container(
            child: Image.network(
              "https://cdn-icons-png.flaticon.com/512/1946/1946429.png",
            ),
          ),
        ),
      ),
    );
  }
}
