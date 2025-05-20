import 'package:flutter/material.dart';

class AppLoadingOverlay extends StatelessWidget {
  AppLoadingOverlay({
    super.key,
    required this.child,
    required this.overlayWidget,
    required this.isLoading,
    this.opacity = 0.8,
  });

  final Widget child;
  final Widget overlayWidget;
  final bool isLoading;
  double opacity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Opacity(
            opacity: opacity,
            child: const ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (isLoading) overlayWidget,
      ],
    );
  }
}
