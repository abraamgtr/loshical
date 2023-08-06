import 'package:hooks_riverpod/hooks_riverpod.dart';

final resultProvider = StateNotifierProvider<Result, int>((_) => Result());

class Result extends StateNotifier<int> {
  String? imagePath;
  String? imageId;
  Result() : super(0);

  void reset() => state = 0;
}
