import 'dart:math';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:lucasconnellm/components/headshot.dart';
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
      title: 'Lucas Connell',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      themeMode: currentTheme,
      home: const MyHomePage(title: 'Lucas'),
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
              await launchUrl(Uri(
                scheme: 'mailto',
                path: 'hello@lucasmc.com',
              ));
            },
            icon: const Icon(FeatherIcons.mail),
          ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 150,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: UserHeadshot(),
                  ),
                ),
                SizedBox(
                  width: min(MediaQuery.of(context).size.width - 160, 500),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Godspeed, traveler.',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0, left: 4.0),
                          child: Text(
                            "My name's Lucas! I'm a software engineer with a background in mathematics."
                            " I graduated from UGA in 2019 with a B.S. in Mathematics and a certificate of"
                            " computing from the Computer Science department. I'm currently working as a"
                            " full-stack engineer at Ryan, LLC in Atlanta, GA.",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0, left: 4.0),
                          child: Text(
                            "My strongest languages are Python and JavaScript/TypeScript, but I'm also"
                            " proficient in Golang and Flutter. My technical abilities include SQL, Docker,"
                            " AWS, and Firebase.",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
