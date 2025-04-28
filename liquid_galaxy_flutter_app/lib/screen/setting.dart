import 'package:flutter/material.dart';
import 'package:lg_ai/service/lg_connection.dart';
import 'package:lottie/lottie.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  LGConnection lg = LGConnection();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: LottieBuilder.asset(
            "assets/night.json",
            // reverse: true,
            // options: LottieOptions(enableApplyingOpacityToLayers: true),
            fit: BoxFit.fill,
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(50),
          child: Center(
            child: Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  // height: 40,
                  child: OutlinedButton(
                    onPressed: () async => await lg.setRefresh(),
                    child: Text(
                      'Refresh Slave Screen',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () async => await lg.relaunch(),
                    child: Text(
                      'Relaunch',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () async => await lg.reboot(),
                    child: Text(
                      'Reboot',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () async => await lg.shutdown(),
                    child: Text(
                      'Power OFF',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
// refresh slave
// reset slave
// clear ballons
// re launch 
// reboot 
// power Off