import 'package:flutter/material.dart';

class DynamicPath {
  const DynamicPath(this.pattern, this.builder);

  final String pattern;
  final Widget Function(BuildContext, String) builder;
}