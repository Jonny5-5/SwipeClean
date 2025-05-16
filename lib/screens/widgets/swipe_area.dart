import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SwipeArea extends StatefulWidget {
  const SwipeArea({super.key});

  @override
  State<SwipeArea> createState() => _SwipeAreaState();
}

class _SwipeAreaState extends State<SwipeArea>
    with SingleTickerProviderStateMixin {
  Offset _offset = Offset.zero;
  late Size _screenSize;
  final double boxSize = 100;
  final double edgeThreshold = 80;
  bool showLeft = false;
  bool showRight = false;
  bool showTop = false;
  bool showBottom = false;

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _offset += details.delta;

      showLeft = _offset.dx < -_screenSize.width / 2 + edgeThreshold;
      showRight = _offset.dx > _screenSize.width / 2 - edgeThreshold - boxSize;
      showTop = _offset.dy < -_screenSize.height / 2 + edgeThreshold;
      showBottom =
          _offset.dy > _screenSize.height / 2 - edgeThreshold - boxSize;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    Offset newOffset = _offset;

    if (showLeft) {
      newOffset = Offset(-_screenSize.width / 2 + boxSize / 2 + 16, _offset.dy);
      HapticFeedback.mediumImpact();
    } else if (showRight) {
      newOffset = Offset(_screenSize.width / 2 - boxSize / 2 - 16, _offset.dy);
      HapticFeedback.mediumImpact();
    } else if (showTop) {
      newOffset =
          Offset(_offset.dx, -_screenSize.height / 2 + boxSize / 2 + 16);
      HapticFeedback.mediumImpact();
    } else if (showBottom) {
      newOffset = Offset(_offset.dx, _screenSize.height / 2 - boxSize / 2 - 16);
      HapticFeedback.mediumImpact();
    }

    setState(() {
      _offset = newOffset;
      showLeft = showRight = showTop = showBottom = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          // Edge Zones
          if (showLeft)
            Align(
              alignment: Alignment.centerLeft,
              child: Container(width: edgeThreshold, color: Colors.red),
            ),
          if (showRight)
            Align(
              alignment: Alignment.centerRight,
              child: Container(width: edgeThreshold, color: Colors.green),
            ),
          if (showTop)
            Align(
              alignment: Alignment.topCenter,
              child: Container(height: edgeThreshold, color: Colors.blue),
            ),
          if (showBottom)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(height: edgeThreshold, color: Colors.orange),
            ),

          // Draggable Box
          Center(
            child: GestureDetector(
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,
              child: Transform.translate(
                offset: _offset,
                child: Material(
                  elevation: 12,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: boxSize,
                    height: boxSize,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: const Text('Drag'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
