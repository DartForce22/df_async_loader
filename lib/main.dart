import 'package:flutter/material.dart';

import '/eg_object.dart';
import '/loading_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// Example method that simulates waiting for a `void` function to complete while showing a loading dialog.
  ///
  /// Once the operation finishes, a snack bar with a message is displayed.
  void _waitForVoidFunction(BuildContext context) {
    LoadingDialog.callMethodWithLoadingDialog<void>(
      context: context,
      callback: () async {
        // Simulating a delay to mimic an asynchronous task.
        await Future.delayed(const Duration(seconds: 2));
      },
      onFinished: (_) {
        // Show a message when the task completes.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("CALLED VOID FUNCTION")),
        );
      },
    );
  }

  /// Example method that simulates waiting for an `int` function to complete while showing a loading dialog.
  ///
  /// Once the operation finishes, a snack bar with the result is displayed.
  void _waitForIntFunction(BuildContext context) {
    LoadingDialog.callMethodWithLoadingDialog<int>(
      context: context,
      callback: () async {
        // Simulating a delay and returning an integer result.
        await Future.delayed(const Duration(seconds: 2));
        return 5;
      },
      onFinished: (res) {
        // Show a message with the result when the task completes.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("CALLED INT FUNCTION result = $res")),
        );
      },
    );
  }

  /// Example method that simulates waiting for a `String` function to complete while showing a loading dialog.
  ///
  /// Once the operation finishes, a snack bar with the result is displayed.
  void _waitForStringFunction(BuildContext context) {
    LoadingDialog.callMethodWithLoadingDialog<String>(
      context: context,
      callback: () async {
        // Simulating a delay and returning a string result.
        await Future.delayed(const Duration(seconds: 2));
        return "RESULT!";
      },
      onFinished: (res) {
        // Show a message with the result when the task completes.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("CALLED STRING FUNCTION result = $res")),
        );
      },
    );
  }

  /// Example method that simulates waiting for an `EgObject` to complete while showing a custom loading dialog.
  ///
  /// Once the operation finishes, a snack bar with the object's values is displayed.
  void _waitForObjectFunction(BuildContext context) {
    LoadingDialog.callMethodWithLoadingDialog<EgObject>(
      context: context,
      customBody: const SizedBox(
        height: 12,
        child: LinearProgressIndicator(),
      ),
      callback: () async {
        // Simulating a delay and returning a custom object.
        await Future.delayed(const Duration(seconds: 2));
        return const EgObject(
          value1: "Value 1",
          value2: false,
        );
      },
      onFinished: (res) {
        // Show a message with the object's values when the task completes.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  "CALLED OBJECT FUNCTION values = ${res.value1} & ${res.value2}")),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MaterialApp(
        builder: (ctx, __) => Scaffold(
          body: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _waitForVoidFunction(ctx);
                  },
                  child: const Text("Call Void Function"),
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    _waitForIntFunction(ctx);
                  },
                  child: const Text("Call Int Function"),
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    _waitForStringFunction(ctx);
                  },
                  child: const Text("Call String Function"),
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    _waitForObjectFunction(ctx);
                  },
                  child: const Text("Call Object Function with custom loading"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
