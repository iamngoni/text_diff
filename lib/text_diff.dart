//
//  text_diff
//  text_diff.dart
//
//  Created by Ngonidzashe Mangudya on 12/06/2024.
//  Copyright (c) 2024 Codecraft Solutions. All rights reserved.
//

import 'package:diff_match_patch/diff_match_patch.dart';
import 'package:flutter/material.dart';

class TextDiffPage extends StatefulWidget {
  const TextDiffPage({super.key});

  @override
  State<TextDiffPage> createState() => _TextDiffPageState();
}

class _TextDiffPageState extends State<TextDiffPage> {
  final TextEditingController textController1 = TextEditingController();
  final TextEditingController textController2 = TextEditingController();
  List<Diff> diffs = [];

  void compareTexts() {
    final diffMatchPatch = DiffMatchPatch();
    final diffs = diffMatchPatch.diff(
      textController1.text,
      textController2.text,
    );
    setState(() {
      this.diffs = diffs;
    });
  }

  List<TextSpan> buildDiffTextSpans() {
    return diffs.map((diff) {
      final textStyle = diff.operation == DIFF_INSERT
          ? const TextStyle(backgroundColor: Colors.greenAccent)
          : diff.operation == DIFF_DELETE
              ? const TextStyle(backgroundColor: Colors.redAccent)
              : const TextStyle();
      return TextSpan(
        text: diff.text,
        style: textStyle,
      );
    }).toList();
  }

  @override
  void dispose() {
    textController1.dispose();
    textController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Diff'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController1,
                      decoration: const InputDecoration(
                        labelText: 'Text 1',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 100,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: textController2,
                      decoration: const InputDecoration(
                        labelText: 'Text 2',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 100,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: compareTexts,
              child: const Text('Compare'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: RichText(
                  text: TextSpan(
                    children: buildDiffTextSpans(),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
