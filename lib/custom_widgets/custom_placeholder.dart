import 'package:flutter/material.dart';

import '../gpt_markdown.dart';
import 'markdown_config.dart';

class PlaceholderMd extends BlockMd {
  @override
  String get expString =>
      // ![desc](type:id=xxx) or [desc](type:id=xxx)
      r'!?\[[^\]]*\]\((?<type1>[A-Za-z_]+):id=(?<id1>[^)]+)\)'
      // (type:id=xxx)
      r'|\((?<type2>[A-Za-z_]+):id=(?<id2>[^)]+)\)'
      // [type:id=xxx]
      r'|\[(?<type3>[A-Za-z_]+):id=(?<id3>[^\]]+)\]';

  @override
  Widget build(
      BuildContext context,
      String text,
      final GptMarkdownConfig config,
      ) {
    var match = exp.firstMatch(text.trim());

    if (match == null || config.placeholderBuilder == null) {
      return const SizedBox.shrink();
    }

    final type = match.namedGroup('type1') ?? match.namedGroup('type2') ?? match.namedGroup('type3');
    final id = match.namedGroup('id1') ?? match.namedGroup('id2') ?? match.namedGroup('id3');

    return config.placeholderBuilder!(context, type!, id!, config);
  }
}