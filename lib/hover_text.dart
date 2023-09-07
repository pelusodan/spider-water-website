import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/events.dart';
import 'package:flutter/widgets.dart';

class HoverText extends StatefulWidget {
  final Color baseColor;
  final Color hoverColor;
  final TextStyle textStyle;
  final Widget child;

  const HoverText(
      {super.key,
      required this.baseColor,
      required this.hoverColor,
      required this.textStyle,
      required this.child});

  @override
  State<StatefulWidget> createState() {
    return _HoverTextState();
  }
}

class _HoverTextState extends State<HoverText> {
  Color? currentColor;

  @override
  void initState() {
    currentColor = widget.baseColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      //onHover: _onHover,
      child: DefaultTextStyle(
        style: widget.textStyle.copyWith(
          color: currentColor ?? widget.baseColor,
        ),
        child: widget.child,
      ),
    );
  }

  void _onEnter(PointerEnterEvent event) {
    setState(() {
      currentColor = widget.hoverColor;
    });
  }

  void _onExit(PointerExitEvent event) {
    setState(() {
      currentColor = widget.baseColor;
    });
  }
}
