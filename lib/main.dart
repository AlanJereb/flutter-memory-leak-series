import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import "package:leak_tracker/leak_tracker.dart";

void main() {
  LeakTracking.start();
  FlutterMemoryAllocations.instance.addListener((ObjectEvent event) {
    LeakTracking.dispatchObjectEvent(event.toMap());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memory Leaks demo app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final _leakingAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    // we are not disposing _leakingAnimation on purpose
    super.dispose();
  }

  void _induceMemoryLeak() {
    _leakingAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Memory Leaks demo page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextButton(onPressed: _induceMemoryLeak, text: "Add a leak"),
            const SizedBox(height: 30),
            CustomTextButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SecondPage())),
              text: "Navigate",
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: const Text("Memory Leaks demo page - 2")),
      body: Center(
        child: CustomTextButton(
          onPressed: () async {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
            await Future.delayed(const Duration(milliseconds: 500)); // let leak_tracker settle
            Leaks leaks = await LeakTracking.collectLeaks();
            print("Leaks collected");
          },
          text: "Navigate back and collect leaks",
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, required this.text, required this.onPressed});

  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
