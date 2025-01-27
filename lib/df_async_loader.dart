import 'package:df_async_loader/df_settings.dart';
import 'package:flutter/material.dart';

/// A utility class for showing a loading dialog while performing asynchronous tasks.

class DfAsyncLoader {
  static final _settings = DfSettings.getInstance();

  /// Displays a loading dialog while executing the provided asynchronous [callback].
  ///
  /// The [callback] function is a `Future` that runs in the background while the loading dialog is displayed.
  /// Once the [callback] completes, the loading dialog is removed, and optionally the [onFinished] callback is invoked
  /// with the result of the [callback].
  ///
  /// - [context]: The `BuildContext` used to display the dialog.
  /// - [callback]: A `Future` function that runs while the loading dialog is shown.
  /// - [onFinished]: A callback invoked when the [callback] completes, passing the result of the [callback].
  /// - [message]: A message to be displayed inside the dialog. Defaults to "Loading".
  /// - [decoration]: Optional custom `BoxDecoration` for styling the container.
  /// - [containerHeight]: Optional height for the dialog container. Defaults to 140.
  /// - [containerWidth]: Optional width for the dialog container. Defaults to 200.
  /// - [customBody]: Custom widget that can replace the default loading dialog content.
  /// - [loadingIndicator]: Optional widget for a loading indicator. Defaults to `CircularProgressIndicator`.
  /// - [textStyle]: Optional text style for the message inside the dialog.
  static showLoader<T>({
    required BuildContext context,
    required Future<T> Function() callback,
    Function(T)? onFinished,
    String? message,
    BoxDecoration? decoration,
    double? containerHeight,
    double? containerWidth,
    Widget? customBody,
    Widget? loadingIndicator,
    TextStyle? textStyle,
  }) async {
    BoxDecoration getContainerDecoration() {
      if (decoration != null) return decoration;

      if (_settings.decoration != null) return _settings.decoration!;

      return const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      );
    }

    Widget? getCustomBody() {
      return customBody ?? _settings.customBody;
    }

    TextStyle getTextStyle() {
      if (textStyle != null) return textStyle;

      if (_settings.textStyle != null) return _settings.textStyle!;

      return const TextStyle(
        fontSize: 25,
        color: Colors.black,
      );
    }

    Widget getLoadingIndicator() {
      if (loadingIndicator != null) return loadingIndicator;

      if (_settings.loadingIndicator != null) {
        return _settings.loadingIndicator!;
      }

      return const CircularProgressIndicator();
    }

    double getContainerHeight() {
      if (containerHeight != null) return containerHeight;
      if (_settings.containerHeight != null) return _settings.containerHeight!;

      return 140;
    }

    double getContainerWidth() {
      if (containerWidth != null) return containerWidth;
      if (_settings.containerWidth != null) return _settings.containerWidth!;

      return 200;
    }

    var myDialogRoute = DialogRoute(
      useSafeArea: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            child: PopScope(
              canPop: false,
              child: getCustomBody() ??
                  Center(
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        height: getContainerHeight(),
                        width: getContainerWidth(),
                        padding: const EdgeInsets.all(16),
                        decoration: getContainerDecoration(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (message != null) ...[
                              Text(
                                message,
                                style: getTextStyle(),
                              ),
                              const SizedBox(height: 16),
                            ],
                            getLoadingIndicator(),
                          ],
                        ),
                      ),
                    ),
                  ),
            ));
      },
    );
    Navigator.of(context).push(myDialogRoute);

    var res = await callback();

    if (myDialogRoute.isActive && context.mounted) {
      Navigator.of(context).removeRoute(myDialogRoute);
    }

    if (onFinished != null) {
      onFinished(res);
    }
  }
}
