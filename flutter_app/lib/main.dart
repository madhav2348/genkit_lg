import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:lg_ai/screen/navigation.dart';
import 'package:lg_ai/service/ai_service.dart';
import '/theme.dart';
import 'package:provider/provider.dart';

Future main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeChanger()),
        // ChangeNotifierProvider(create: (_) => GeminiService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeprovider = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeprovider.themeMode,
      darkTheme: ThemeData.dark(),

      // theme: themeprovider.check(),
      theme: allThemeData,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          // title: Text('KISS App', style: TextStyle(color: Colors.white)),
          // elevation: 4,
          // backgroundColor: Colors.white12, // This will override the theme
          // foregroundColor: Colors.white12,
        ),
        body: Navigation(),
      ),
    );
  }
}
