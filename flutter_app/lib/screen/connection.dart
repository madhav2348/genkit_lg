import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '/service/lg_connection.dart';
import '/service/shared_pref.dart';
import '/service/ssh_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  bool isConnected = false;

  final LGConnection _lg = LGConnection();
  SSHService ssh = SSHService();

  final TextEditingController _user = TextEditingController(text: 'lg');
  final TextEditingController _pass = TextEditingController(text: 'lg');
  final TextEditingController _ip = TextEditingController();
  final TextEditingController _rigs = TextEditingController(text: '3');
  final TextEditingController _port = TextEditingController(text: '22');

  Future<List<String?>> _getPersistence() async {
    SharedPreferencesWithCache prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        // allowList: <String>{'repeat', 'action'},
      ),
    );

    final pIp = prefs.getString('master_ip');
    final pPass = prefs.getString('master_password');
    final pPort = prefs.getString('master_portNumber');
    final pUser = prefs.getString('master_username');

    _user.text = pUser!;
    _pass.text = pPass!;
    _ip.text = pIp!;
    _port.text = pPort!;
    return [pIp, pPass, pPort, pUser];
  }

  onSubmit(
    String user,
    String pass,
    String ip,
    String port,
    String rigs,
  ) async {
    // Navigator.pop(context);
    await SharedPref.setData(user, pass, ip, port, rigs, true);
    showDialog(
      context: context,
      builder: (context) {
        Future.delayed(const Duration(seconds: 5), () {
          Navigator.of(context).pop();
        });
        return SizedBox(
          width: 100,
          height: 100,
          child: Center(child: CircularProgressIndicator(color: Colors.white)),
        );
      },
    );
    await _lg.connect();

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _getPersistence();
  }

  @override
  void dispose() {
    super.dispose();
    _ip.dispose();
    _pass.dispose();
    _port.dispose();
    _user.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: LottieBuilder.asset('assets/night.json', fit: BoxFit.fill),
        ),
        Center(
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Form(
                child: Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Connect with LG',
                      style: GoogleFonts.montserrat(
                        textStyle: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    // SizedBox(width: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        // prefixIcon: Icon(Icons.person_2_outlined),
                        border: OutlineInputBorder(),

                        label: Text('Username'),
                      ),
                      controller: _user,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),

                        label: Text('Password'),
                        // prefixIcon: Icon(Icons.key_outlined),
                      ),
                      controller: _pass,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(),

                        label: Text('IP Address'),
                        // prefixIcon: Icon(Icons.router_outlined),
                      ),
                      controller: _ip,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),

                        label: Text('Port'),
                        // prefixIcon: Icon(Icons.computer_outlined),
                      ),
                      controller: _port,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),

                        label: Text('Number of rigs'),
                        // prefixIcon: Icon(Icons.computer_outlined),
                      ),
                      controller: _rigs,
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          onSubmit(
                            _user.text,
                            _pass.text,
                            _ip.text,
                            _port.text,
                            _rigs.text,
                          );
                          setState(() {
                            isConnected = !isConnected;
                          });
                        },
                        child: Text(
                          'Connect',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
