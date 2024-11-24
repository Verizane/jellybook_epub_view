import 'package:epubx/epubx.dart';
import 'package:flutter/material.dart';
import 'package:jellybook_epub_view/src/data/models/paragraph.dart';
import 'package:jellybook_epub_view/src/enums/epub_view_loading_state.dart';
import 'package:jellybook_epub_view/src/helpers/external_link_pressed.dart';
import 'package:jellybook_epub_view/src/models/epub_view_state.dart';

typedef EpubViewBuilder<T> = Widget Function(
  /// Build context
  BuildContext context,

  /// All passed builders
  EpubViewBuilders<T> builders,

  /// Document loading state
  EpubViewLoadingState state,

  /// Loaded result builder
  WidgetBuilder loadedBuilder,

  /// Error of pdf loading
  Exception? loadingError,
);

typedef ChaptersBuilder = Widget Function(
  BuildContext context,
  EpubViewBuilders builders,
  EpubBook document,
  List<EpubChapter> chapters,
  List<Paragraph> paragraphs,
  int index,
  int chapterIndex,
  int paragraphIndex,
  ExternalLinkPressed onExternalLinkPressed,
);

typedef ChapterDividerBuilder = Widget Function(EpubChapter value);

class EpubViewBuilders<T> {
  /// Root view builder
  final EpubViewBuilder<T> builder;

  final ChaptersBuilder chapterBuilder;
  final ChapterDividerBuilder chapterDividerBuilder;

  /// Widget showing when epub page loading
  final WidgetBuilder? loaderBuilder;

  /// Show document loading error message inside [EpubView]
  final Widget Function(BuildContext, Exception error)? errorBuilder;

  /// Additional options for builder
  final T options;

  const EpubViewBuilders({
    required this.options,
    this.builder = EpubViewState.builder,
    this.chapterBuilder = EpubViewState.chapterBuilder,
    this.chapterDividerBuilder = EpubViewState.chapterDividerBuilder,
    this.loaderBuilder,
    this.errorBuilder,
  });
}

class DefaultBuilderOptions {
  final Duration loaderSwitchDuration;
  final AnimatedSwitcherTransitionBuilder transitionBuilder;
  final EdgeInsetsGeometry chapterPadding;
  final EdgeInsetsGeometry paragraphPadding;
  final TextStyle textStyle;

  const DefaultBuilderOptions({
    this.loaderSwitchDuration = const Duration(seconds: 1),
    this.transitionBuilder = DefaultBuilderOptions._transitionBuilder,
    this.chapterPadding = const EdgeInsets.all(8),
    this.paragraphPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.textStyle = const TextStyle(
      height: 1.25,
      fontSize: 16,
    ),
  });

  static Widget _transitionBuilder(Widget child, Animation<double> animation) =>
      FadeTransition(opacity: animation, child: child);
}
