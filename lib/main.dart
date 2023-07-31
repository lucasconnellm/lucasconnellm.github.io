import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri githubUri = Uri(
  scheme: 'https',
  host: 'github.com',
  path: 'lucasconnellm',
);
final Uri linkedinUri = Uri(
  scheme: 'https',
  host: 'www.linkedin.com',
  path: 'in/lucas-connell-uga',
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();

  static MyAppState of(BuildContext context) {
    return context.findAncestorStateOfType<MyAppState>()!;
  }
}

class MyAppState extends State<MyApp> {
  ThemeMode currentTheme = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      themeMode: currentTheme,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }

  void switchTheme(ThemeMode theme) {
    setState(() {
      currentTheme = theme;
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeMode targetThemeMode;
    MyAppState currentAppState = MyApp.of(context);
    if (currentAppState.currentTheme == ThemeMode.system) {
      var systemBrightness = MediaQuery.of(context).platformBrightness;
      if (systemBrightness == Brightness.dark) {
        targetThemeMode = ThemeMode.light;
      } else {
        targetThemeMode = ThemeMode.dark;
      }
    } else if (currentAppState.currentTheme == ThemeMode.dark) {
      targetThemeMode = ThemeMode.light;
    } else {
      targetThemeMode = ThemeMode.dark;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () async {
                await launchUrl(githubUri);
              },
              icon: const Icon(FeatherIcons.github)),
          IconButton(
              onPressed: () async {
                await launchUrl(linkedinUri);
              },
              icon: const Icon(FeatherIcons.linkedin)),
          IconButton(
            icon: targetThemeMode == ThemeMode.light
                ? const Icon(Icons.light_mode_rounded)
                : const Icon(Icons.dark_mode_rounded),
            onPressed: () {
              currentAppState.switchTheme(targetThemeMode);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
