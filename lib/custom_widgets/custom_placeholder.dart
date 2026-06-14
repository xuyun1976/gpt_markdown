import 'package:flutter/material.dart';

import '../gpt_markdown.dart';
import 'markdown_config.dart';

class PlaceholderMd extends BlockMd {
  @override
  String get expString => r"\[([A-Za-z_]+):id=([^\]]+)\]";

  @override
  Widget build(
      BuildContext context,
      String text,
      final GptMarkdownConfig config,
      ) {
    var match = exp.firstMatch(text.trim());

    if (match == null) {
      return const SizedBox.shrink();
    }

    String type = match[1]!;
    String id = match[2]!;

    if (config.placeholderBuilder == null) {
      return const SizedBox.shrink();
    }

    return config.placeholderBuilder!(context, type, id, config);
  }
}