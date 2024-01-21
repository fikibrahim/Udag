import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uber/constant/utils/colors.dart';

class ElevatedButtonCommon extends StatefulWidget {
  ElevatedButtonCommon({
    super.key,
    required this.onPressed,
    required this.child,
    required this.backgroundColor,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  final VoidCallback onPressed;
  final Widget child;
  final Color backgroundColor;
  final double width;
  final double height;
  double? borderRadius;

  @override
  State<ElevatedButtonCommon> createState() => _ElevatedButtonCommonState();
}

class _ElevatedButtonCommonState extends State<ElevatedButtonCommon> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.backgroundColor,
        minimumSize: Size(
          widget.width,
          widget.height,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.sp),
        ),
      ),
      child: widget.child,
    );
  }
}
