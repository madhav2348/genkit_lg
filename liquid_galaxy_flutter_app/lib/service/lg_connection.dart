import 'dart:async';

import 'package:lg_ai/model/ai_data_model.dart';

import '/model/kml.dart';
// import '../model/clear_kml.dart';
import '/service/shared_pref.dart';
import '/service/ssh_service.dart';
import '/showtoast.dart';

class LGConnection {
  final ssh = SSHService();
  bool _established = false;
  bool get establish => _established;

  final String _url = '\nhttp://lg1:81';

  Future<void> sendKml(KML kml, Location location) async {
    final fileName = '${kml.heading}.kml';
    print(kml.fileKML);
    try {
      await ssh.connectToserver();
      await ssh.execute('echo \'${kml.fileKML}\' > /var/www/html/$fileName');

      await ssh.execute('echo "$_url/$fileName" > /var/www/html/kmls.txt');
      await flyTo(location.flyToLocation);
      showToast('KML Send');
    } catch (e) {
      showToast('Connection Failed KML not sended');

      throw Exception(e);
    }
  }

  Future<void> clearKml() async {
    String query =
        'echo "exittour=true" > /tmp/query.txt && > /var/www/html/kmls.txt';
    try {
      await ssh.connectToserver();
      showToast('Clear KML');
      await ssh.execute(query);
    } catch (e) {
      showToast('Something went wrong');

      throw Exception(e);
    }
  }

  Future<void> flyTo(String location) async {
    await ssh.execute('echo "flytoview=$location" > /tmp/query.txt');
    showToast('Flying...');
  }

  setRefresh() async {
    final data = await SharedPref.getData();
    final passwordOrKey = data['pass']!;
    //  final _client = await ssh.connectToserver();
    try {
      for (var i = 2; i <= 3; i++) {
        String search = '<href>##LG_PHPIFACE##kml\\/slave_$i.kml<\\/href>';
        String replace =
            '<href>##LG_PHPIFACE##kml\\/slave_$i.kml<\\/href><refreshMode>onInterval<\\/refreshMode><refreshInterval>2<\\/refreshInterval>';

        await ssh.execute(
          'sshpass -p $passwordOrKey ssh -t lg$i \'echo $passwordOrKey |sudo -S sed -i "s/$replace/$search/"~/earth/kml/slave/myplaces.kml\'',
        );
        await ssh.execute(
          'sshpass -p $passwordOrKey ssh -t lg$i \'echo $passwordOrKey | sudo -S sed -i "s/$search/$replace/" ~/earth/kml/slave/myplaces.kml\'',
        );
      }
      showToast('Refreshing....');
    } catch (e) {
      throw Exception(e);
    }
    await reboot();
  }

  Future<void> reboot() async {
    final data = await SharedPref.getData();
    final pw = data['pass']!;

    for (var i = 3; i >= 1; i--) {
      try {
        await ssh.execute(
          'sshpass -p $pw ssh -t lg$i "echo $pw | sudo -S reboot"',
        );
        showToast('Reboot ...');
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }
  }

  Future<void> relaunch() async {
    final data = await SharedPref.getData();
    final pw = data['pass']!;
    final user = data['user'];

    for (var i = 3; i >= 1; i--) {
      try {
        final relaunchCommand = """RELAUNCH_CMD="\\
if [ -f /etc/init/lxdm.conf ]; then
  export SERVICE=lxdm
elif [ -f /etc/init/lightdm.conf ]; then
  export SERVICE=lightdm
else
  exit 1
fi
if  [[ \\\$(service \\\$SERVICE status) =~ 'stop' ]]; then
  echo $pw | sudo -S service \\\${SERVICE} start
else
  echo $pw | sudo -S service \\\${SERVICE} restart
fi
" && sshpass -p $pw ssh -x -t lg@lg$i "\$RELAUNCH_CMD\"""";
        await ssh.execute(
          '"/home/$user/bin/lg-relaunch" > /home/$user/log.txt',
        );
        await ssh.execute(relaunchCommand);
        showToast('Relaunch ...');
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }
  }

  Future<void> shutdown() async {
    final data = await SharedPref.getData();
    final pw = data['pass']!;

    for (var i = 3; i >= 1; i--) {
      try {
        await ssh.execute(
          'sshpass -p $pw ssh -t lg$i "echo $pw | sudo -S poweroff"',
        );
        showToast('Shutdown ....');
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }
  }

  Future<void> resetRefresh() async {
    final data = await SharedPref.getData();
    final pw = data['pass']!;

    const search =
        '<href>##LG_PHPIFACE##kml\\/slave_{{slave}}.kml<\\/href><refreshMode>onInterval<\\/refreshMode><refreshInterval>2<\\/refreshInterval>';
    const replace = '<href>##LG_PHPIFACE##kml\\/slave_{{slave}}.kml<\\/href>';

    final clear =
        'echo $pw | sudo -S sed -i "s/$search/$replace/" ~/earth/kml/slave/myplaces.kml';

    for (var i = 2; i <= 3; i++) {
      final cmd = clear.replaceAll('{{slave}}', i.toString());
      String query = 'sshpass -p $pw ssh -t lg$i \'$cmd\'';

      try {
        await ssh.execute(query);
        showToast('Reset  Refresh. ...');
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }

    await reboot();
  }

  Future<void> connect() async {
    try {
      await ssh.connectToserver();
      showToast('Connected');
      _established = true;
    } catch (e) {
      showToast('Connection Failed');
      _established = false;

      throw Exception(e);
    }
  }

  Future<void> disconnect() async {
    ssh.disconnect();
    _established = false;
    showToast('Disconnected');
  }
}
