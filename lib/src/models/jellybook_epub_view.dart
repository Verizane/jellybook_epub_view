
import 'package:flutter/material.dart';
import 'package:jellybook_epub_view/src/data/models/chapter_view_value.dart';
import 'package:jellybook_epub_view/src/helpers/epub_view_builders.dart';
import 'package:jellybook_epub_view/src/helpers/external_link_pressed.dart';
import 'package:jellybook_epub_view/src/models/epub_view_state.dart';
import 'package:jellybook_epub_view/src/epub_controller.dart';

class JellybookEpubView extends StatefulWidget {
  const JellybookEpubView(
    this.onExternalLinkPressed, {
    required this.controller,
    this.onChapterChanged,
    this.onDocumentLoaded,
    this.onDocumentError,
    this.builders = const EpubViewBuilders<DefaultBuilderOptions>(
      options: DefaultBuilderOptions(),
    ),
    this.shrinkWrap = false,
    Key? key,
  }) : super(key: key);

  final EpubController controller;
  final ExternalLinkPressed onExternalLinkPressed;
  final bool shrinkWrap;
  final void Function(EpubChapterViewValue? value)? onChapterChanged;

  /// Called when a document is loaded
  final void Function(EpubBook document)? onDocumentLoaded;

  /// Called when a document loading error
  final void Function(Exception? error)? onDocumentError;

  /// Builders
  final EpubViewBuilders builders;

  @override
  State<JellybookEpubView> createState() => EpubViewState();
}