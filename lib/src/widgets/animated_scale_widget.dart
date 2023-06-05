import 'package:flutter/material.dart';

class AnimatedScaleWidget extends StatefulWidget {
  final Widget child;
  const AnimatedScaleWidget({required this.child, super.key});

  @override
  State<AnimatedScaleWidget> createState() => _AnimatedScaleWidgetState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _AnimatedScaleWidgetState extends State<AnimatedScaleWidget> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    //easeOut
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}
