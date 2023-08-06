import 'package:flutter/material.dart';
import 'package:loshical/hugged_child.dart';
import 'package:loshical/question_screen.dart';

class AnswerImage extends StatefulWidget {
  final String assetPath;
  final GlobalKey? key;
  const AnswerImage({this.key, required this.assetPath});

  @override
  State<AnswerImage> createState() => _AnswerImageState();
}

class _AnswerImageState extends State<AnswerImage> {
  Offset position = Offset(0.0, 0.0);
  Offset initPos = Offset(0.0, 0.0);
  AssetImage? _imageToShow;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(microseconds: 3), () {
      RenderBox box =
          widget.key?.currentContext?.findRenderObject() as RenderBox;
      Offset widgetPos = box.localToGlobal(Offset.zero);
      initPos = widgetPos;
      position = widgetPos;
    });
    _imageToShow = AssetImage(widget.assetPath);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      bottom: 0.0,
      child: Draggable<AssetImage>(
        data: AssetImage(widget.assetPath),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: _imageToShow ?? AssetImage(""),
            ),
          ),
          child: HuggedChild(child: Image.asset(widget.assetPath)),
        ),
        onDraggableCanceled: (velocity, offset) {
          setState(() {
            position = initPos;
          });
        },
        onDragStarted: () {
          setState(() {
            print('drag started');
            _imageToShow = new AssetImage(widget.assetPath);
          });
        },
        onDragUpdate: (details) {
          //print(details.localPosition.dx);
          print(details.localPosition.dy);
          if ((details.localPosition.dx > 112.0 &&
                  details.localPosition.dx < 177) &&
              (details.localPosition.dy > 100.0 &&
                  details.localPosition.dy < 220.0)) {
            if (widget.assetPath.split("/")[1].split(".")[0] == "a5") {
              print("true");
              go = true;
              useAnswerChosenState.value = widget.assetPath;
              useAnswerState.value = true;
            } else {
              print("false");
              go = true;
              useAnswerChosenState.value = widget.assetPath;
              useAnswerState.value = false;
            }
            useAnswerChosenState.notifyListeners();
            useAnswerState.notifyListeners();
          }
        },
        feedback: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: _imageToShow ?? AssetImage(""),
            ),
          ),
          child: HuggedChild(child: Image.asset(widget.assetPath)),
        ),
      ),
    );
  }
}
//HuggedChild(key: widget.key, child: Image.asset(widget.assetPath))