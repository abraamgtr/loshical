import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loshical/Result_screen.dart';
import 'package:loshical/question_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return QuestionScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'result',
          name: "result",
          builder: (BuildContext context, GoRouterState state) {
            return ResultPage(
              imagePath: state.queryParameters["imagePath"]!,
              imageId: state.queryParameters["imageId"]!,
            );
          },
        ),
      ],
    ),
  ],
);
