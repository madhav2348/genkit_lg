import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPref instance = SharedPref._internal();

  factory SharedPref() {
    return instance;
  }
  SharedPref._internal();
  static Future<Map<String, dynamic>> getData() async {
    SharedPreferencesWithCache prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        // allowList: <String>{'repeat', 'action'},
      ),
    );

    final pIp = prefs.getString('master_ip');
    final pPass = prefs.getString('master_password');
    final pPort = prefs.getString('master_portNumber');
    final pUser = prefs.getString('master_username');
    final pRigs = prefs.getString('master_rigs');
    final pEst = prefs.getBool('established');

    return {
      "ip": pIp!,
      "pass": pPass!,
      "port": pPort!,
      "user": pUser!,
      "rigs": pRigs!,
      "est": pEst!,
    };
  }

  static Future<void> setData(
    String user,
    String pass,
    String ip,
    String port,
    String rigs,
    bool est,
  ) async {
    final SharedPreferencesWithCache prefsWithCache =
        await SharedPreferencesWithCache.create(
          cacheOptions: const SharedPreferencesWithCacheOptions(
            // allowList: <String>{'repeat', 'action'},
          ),
        );

    await prefsWithCache.setString('master_ip', ip);
    await prefsWithCache.setString('master_password', pass);
    await prefsWithCache.setString('master_portNumber', port);
    await prefsWithCache.setString('master_username', user);
    await prefsWithCache.setString('master_rigs', rigs);
    await prefsWithCache.setBool('established', est);
  }
}
