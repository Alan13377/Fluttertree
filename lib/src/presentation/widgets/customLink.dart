import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomLink extends StatelessWidget {
  final String link;
  final icon;
  final url;
  const CustomLink(
      {super.key, required this.link, required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final size = MediaQuery.of(context).size;

    return Container(
      constraints: BoxConstraints(
        minWidth: size.width * 0.4,
        maxWidth: size.width * 0.6,
      ),
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5.6, horizontal: 10),
          onTap: () async {
            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url));
            }
          },
          leading: SvgPicture.network(
            icon,
            width: size.width * 0.05,
            height: size.height * 0.04,
          ),
          title: AutoSizeText(
            link,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: const Icon(Icons.link),
        ),
      ),
    );
  }
}
