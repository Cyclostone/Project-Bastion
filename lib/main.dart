import 'package:bastion_app1/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(NotesApp());

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StreamProvider.value(
        initialData: CurrentUser.initial,
        value: FirebaseAuth.instance.onAuthStateChanged
            .map((user) => CurrentUser.create(user)),
        child: Consumer<CurrentUser>(
          builder: (context, user, _) => MaterialApp(
            title: 'Bastion_flutter',
            home: user.isInitialValue
                ? Scaffold(body: const Text('Loading...'))
                : user.data != null ? HomeScreen() : LoginScreen(),
          ),
        ),
      );
}



/*Back to the project, before testing your login screen, please make sure you’re not ignoring the following settings:
For the Android platform, you must specify the SHA-1 fingerprint in the Firebase console
For the iOS platform, you have to add a custom URL scheme to the Xcode project
For the Web platform, add a meta tag like <meta name="google-signin-client_id" content="{web_client_id}"> to web/index.html, you can find the Web client id in the ‘OAuth 2.0 Client IDs’ section of your project’s credentials page in the Google Cloud console
*/