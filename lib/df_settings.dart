import 'package:flutter/material.dart';

//Class used to configure `df_async_loader` globally

/// - [decoration]: Optional custom `BoxDecoration` for styling the container.
/// - [containerHeight]: Optional height for the dialog container. Defaults to 140.
/// - [containerWidth]: Optional width for the dialog container. Defaults to 200.
/// - [customBody]: Custom widget that can replace the default loading dialog content.
/// - [loadingIndicator]: Optional widget for a loading indicator. Defaults to `CircularProgressIndicator`.
/// - [textStyle]: Optional text style for the message inside the dialog.
///
class DfSettings {
  DfSettings._();

  static DfSettings? _settings;

  ///Optional widget for a loading indicator. Defaults to `CircularProgressIndicator`.
  Widget? loadingIndicator;

  ///Custom widget that can replace the default loading dialog content.
  Widget? customBody;

  ///[containerHeight]: Optional height for the dialog container. Defaults to 140.
  double? containerHeight;

  ///Optional width for the dialog container. Defaults to 200.
  double? containerWidth;

  ///Optional text style for the message inside the dialog.
  TextStyle? textStyle;

  /// Optional custom `BoxDecoration` for styling the container.
  BoxDecoration? decoration;

  static DfSettings getInstance() {
    _settings ??= DfSettings._();

    return _settings!;
  }
}
