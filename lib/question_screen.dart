import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loshical/ResultProvider.dart';
import 'package:loshical/answer_image.dart';
import 'package:loshical/assets.dart';
import 'package:loshical/how_to_play_screen.dart';
import 'package:loshical/question_image.dart';

ValueNotifier<bool?> useAnswerState = ValueNotifier<bool?>(null);

ValueNotifier<String?> useAnswerChosenState = ValueNotifier<String?>(null);
bool go = false;

class QuestionScreen extends HookConsumerWidget {
  //const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ref.watch(resultProvider);
    return Scaffold(
      key: GlobalKey(debugLabel: "main"),
      appBar: AppBar(
        title: const Text('Loshical'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => const HowToPlayScreen()));
            },
            icon: const Icon(Icons.info_outlined),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Choose the image that completes the pattern: '),
              const SizedBox(
                height: 16,
              ),
              Wrap(
                children: AssetManager.questionPaths.map(
                  (e) {
                    return ValueListenableBuilder(
                      valueListenable: useAnswerState,
                      builder: (context, value, child) {
                        if (value != null && go == true) {
                          ref.read(resultProvider.notifier).imagePath =
                              useAnswerChosenState.value;
                          ref.read(resultProvider.notifier).imageId =
                              useAnswerChosenState.value
                                  ?.split("/")[1]
                                  .split(".")[0][1];
                          print(e);
                          Future.delayed(Duration(seconds: 2), () {
                            context.goNamed('result', queryParameters: {
                              "imagePath": e,
                              "imageId": e.split("/")[1].split(".")[0][1],
                            });
                          });
                        }
                        return Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: e.split("/")[1].split(".")[0] == "q2"
                                        ? value != null
                                            ? (value == true
                                                ? Colors.green
                                                : Colors.red)
                                            : Colors.transparent
                                        : Colors.transparent,
                                    width: value != null
                                        ? (value == true ? 3.0 : 3.0)
                                        : 0.0)),
                            child: QuestionImage(
                              assetPath: value != null
                                  ? e == "assets/q2.png"
                                      ? (useAnswerChosenState.value ?? "")
                                      : e
                                  : e,
                            ));
                      },
                    );
                  },
                ).toList(),
              ),
              const Spacer(),
              const Text('Which of the shapes below continues the sequence'),
              const SizedBox(
                height: 16,
              ),
              Wrap(
                children: AssetManager.answerPaths.map(
                  (e) {
                    return AnswerImage(
                      key: GlobalKey(debugLabel: e[1].toString()),
                      assetPath: e,
                    );
                  },
                ).toList(),
              ),
              const SizedBox(
                height: 42,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
