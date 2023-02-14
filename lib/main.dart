import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linsk_bio/src/presentation/pages/home_page.dart';
import 'package:linsk_bio/src/presentation/utils/colors_schemes.dart';
import 'package:linsk_bio/src/presentation/utils/scroll.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluttertr.ee',
      scrollBehavior: AppScrollBehavior(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
          colorScheme: lightColorScheme,
          useMaterial3: true,
          fontFamily: GoogleFonts.spaceMono().fontFamily),
      darkTheme: ThemeData(
          colorScheme: darkColorScheme,
          useMaterial3: true,
          fontFamily: GoogleFonts.spaceMono().fontFamily),
      home: const HomePage(),
    );
  }
}
