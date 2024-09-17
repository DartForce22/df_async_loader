import 'package:flutter/material.dart';

/// A utility class for showing a loading dialog while performing asynchronous tasks.

class AsyncLoader {
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
    String message = "Loading",
    BoxDecoration? decoration,
    double? containerHeight,
    double? containerWidth,
    Widget? customBody,
    Widget? loadingIndicator,
    TextStyle? textStyle,
  }) async {
    var myDialogRoute = DialogRoute(
      useSafeArea: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            child: PopScope(
              canPop: false,
              child: customBody ??
                  Center(
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        height: containerHeight ?? 140,
                        width: containerWidth ?? 200,
                        padding: const EdgeInsets.all(16),
                        decoration: decoration ??
                            const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              message,
                              style: textStyle ??
                                  const TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                  ),
                            ),
                            const SizedBox(height: 16),
                            loadingIndicator ??
                                const CircularProgressIndicator()
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
