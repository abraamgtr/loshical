import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loshical/ResultProvider.dart';
import 'package:loshical/question_screen.dart';

bool once = false;

class ResultPage extends HookConsumerWidget {
  String? imagePath;
  String? imageId;
  ResultPage({Key? key, imagePath, imageId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ref.watch(resultProvider);
    bool correct = false;
    String title = "";
    String message = "";

    if (ref.read(resultProvider.notifier).imageId == "5") {
      correct = true;
    } else {
      correct = false;
    }

    if (correct) {
      title = "You Won!";
      message = "Congrats :)";
    } else {
      title = "Game Over";
      message = "You can try again by hitting reset button";
    }

    final SnackBar _snackBar = SnackBar(
      backgroundColor: correct ? Colors.green : Colors.red,
      content: Column(children: [
        Text(title),
        SizedBox(
          height: 8.0,
        ),
        Text(message),
      ]),
      duration: const Duration(seconds: 5),
    );

    if (!once) {
      Future.delayed(Duration(milliseconds: 500), () {
        once = true;
        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              go = false;
              context.go("/");
            },
            child: Icon(Icons.arrow_back_ios)),
        title: const Text('Result Screen'),
      ),
      body: Center(
        child: Image.asset(ref.read(resultProvider.notifier).imagePath ?? ""),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          go = false;
          ref.read(resultProvider.notifier).reset();
          useAnswerState.value = null;
        },
        child: const Icon(Icons.restore),
      ),
    );
  }
}
