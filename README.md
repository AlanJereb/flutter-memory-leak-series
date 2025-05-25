# Flutter Memory Leak Detection Series

This repository contains the code and examples from my blog post series on detecting memory leaks in Flutter applications.

## Blog Post Series

1. [Flutter – Detecting memory leaks – Introduction](https://www.alanjereb.com/blog/flutter-detecting-memory-leaks-introduction)
2. [Flutter – Detecting memory leaks – Blueprints](https://www.alanjereb.com/blog/flutter-detecting-memory-leaks-blueprints-disposing-non-collectable-objects)
3. [Flutter – Detecting memory leaks – DevTools](https://www.alanjereb.com/blog/flutter-memory-leak-detection-dart-devtools)
4. [Flutter – Detecting memory leaks – Leak Tracker](https://www.alanjereb.com/blog/flutter-detecting-memory-leaks-leak-tracker) (Final post)

## About the Project

This repository demonstrates various techniques for detecting and analyzing memory leaks in Flutter applications, including:

- Using Dart DevTools for memory profiling
- Working with the Dart DevTools
- Implementing the experimental Leak Tracker package

The final example shows how to use the unreleased `leak_tracker` package from the Dart team to identify memory leaks in your Flutter application.

## Leak Tracker Implementation

The most recent implementation demonstrates how to:

1. Set up Leak Tracker in your Flutter application
2. Monitor object allocation and garbage collection
3. Identify objects that survive longer than expected
4. Collect and analyze leak reports

### Important Notes

- The Leak Tracker package is not yet officially released
- A bug fix is required in the package code (see blog post for details)
- This is experimental functionality that may change before official release

## Getting Started

1. Clone this repository
2. Run `flutter pub get` to install dependencies
3. Follow the setup instructions from the blog posts
4. For Leak Tracker:
   - Apply the necessary bug fix to your local Leak Tracker package
   - Run the app and follow the collection process described in the blog

## Requirements

- Flutter 3.27.1+
- Dart 3.6.0+
- Dart DevTools 2.40.2+

## Contributing

This repository is maintained as a companion to the blog post series. While contributions aren't expected, if you find any issues with the implementations, feel free to open an issue.

## License

This project is open-source and available under the MIT License.

## Author

Alan Jereb  
[Website](https://www.alanjereb.com) | [Blog](https://www.alanjereb.com/blog)