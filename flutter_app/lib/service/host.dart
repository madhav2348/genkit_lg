// Endpoint to reach Genkit app, can be localhost for development
// or wherever the live app is hosted ex: Cloud Run.
// For testing on an Android emulator, you need to specify "10.0.2.2:2222"
// instead of the default "localhost:2222".
// See: https://developer.android.com/studio/run/emulator-networking.html
// final String genkitServerEndpoint = 'localhost:2222';

import 'dart:io';

String genkitServerEndpoint() {
  if (Platform.isAndroid) {
    return '10.0.2.2:2222';
  } else {
    return 'localhost:2222';
  }
}
