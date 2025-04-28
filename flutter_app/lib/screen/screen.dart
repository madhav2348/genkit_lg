import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lg_ai/model/ai_data_model.dart';
import 'package:lg_ai/model/kml.dart';
import 'package:lg_ai/service/ai_service.dart';
import 'package:lg_ai/service/lg_connection.dart';
import 'package:lg_ai/showtoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

enum TtsState { playing, stopped, paused, continued }

class _ScreenState extends State<Screen> {
  TextEditingController inputValue = TextEditingController();

  LGConnection lg = LGConnection();
  final FlutterTts flutterTts = FlutterTts();
  Future<void> showLoadingAndWait(
    BuildContext context,
    KML kml,
    Location location,
  ) async {
    try {
      await lg.sendKml(kml, location);
    } catch (e) {
      showToast('something went wrong $e');
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator(color: Colors.white));
      },
    );

    await Future.delayed(Duration(seconds: 5));

    Navigator.of(context).pop();
  }

  Future<void> _speak(String paragraph) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(paragraph);
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final ai = Provider.of<GeminiService>(context);
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Lottie.asset('assets/night.json', fit: BoxFit.fill),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.all(50),
            child: Form(
              child: Column(
                spacing: 30,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '#BuildwithAI',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: inputValue,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the location';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      if (newValue == null || newValue.isEmpty) {
                        showToast('Enter the location');
                      } else {
                        showToast('Searching.....');
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter the Country, city, ....',
                      label: Text(
                        'Location',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () async {},
                      child: Text(
                        'Search',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
