# df_async_loader
`df_async_loader` is a Flutter package that provides a static method to wait for an asynchronous task to complete while displaying a loading dialog. It simplifies handling async tasks by offering built-in user feedback, helping you manage loading states seamlessly in your app.

# Features
- Async Task Execution: Run any asynchronous function with a loading dialog automatically displayed during task execution.
- Simple Integration: Easy to implement in your Flutter projects, ensuring smooth user experiences during long-running operations.
- Customizable Callback: Trigger actions when the async task is complete using the provided callback.

## Example
```dart
 AsyncLoader.showLoader<String>(
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
```

# Installation
Add `df_async_loader` to your `pubspec.yaml`:

## dependencies:
  `df_async_loader: ^1.0.0`
Then, run: `flutter pub get`

## Usage
- Call the `AsyncLoader.showLoader<T>()` method, passing your `context`, the async `callback`, and the `onFinished` function to handle the result once the task completes.


