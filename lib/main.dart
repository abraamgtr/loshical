import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loshical/Routes.dart';
import 'package:loshical/question_screen.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(ProviderScope(child: const Loshical()));
}

class Loshical extends StatelessWidget {
  const Loshical({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
