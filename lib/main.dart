import 'package:bastion_app1/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
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
            theme: Theme.of(context).copyWith(
              brightness: Brightness.light,
              primaryColor: Colors.white,
              accentColor: kAccentColorLight,
              appBarTheme: AppBarTheme.of(context).copyWith(
                  elevation: 0,
                  brightness: Brightness.light,
                  iconTheme: IconThemeData(
                    color: kIconTintLight,
                  )),
              scaffoldBackgroundColor: Colors.white,
              bottomAppBarColor: kBottomAppBarColorLight,
              primaryTextTheme: Theme.of(context).primaryTextTheme.copyWith(
                    headline6: const TextStyle(
                      color: kIconTintLight,
                    ),
                  ),
            ),
            home: user.isInitialValue
                ? Scaffold(body: const Text('Loading...'))
                : user.data != null ? HomeScreen() : LoginScreen(),
            routes: {
              '/settings': (_) => SettingsScreen(),
            },
            onGenerateRoute: _generateRoute,
          ),
        ),
      );

  Route _generateRoute(RouteSettings settings) {
    try {
      return _doGenerateRoute(settings);
    } catch (e, s) {
      debugPrint("failed to generate route for $settings: $e $s");
      return null;
    }
  }

  Route _doGenerateRoute(RouteSettings settings) {
    if (settings.name?.isNotEmpty != true) return null;

    final uri = Uri.parse(settings.name);
    final path = uri.path ?? '';
    switch (path) {
      case '/note': {
        final note = (settings.arguments as Map ?? {})['note'];
        return _buildRoute(settings, (_) => NoteEditor(note: note));
      }
      default:
      return null;
    }
  }

  // ignore: missing_return
  Route _buildRoute(RouteSettings settings, WidgetBuilder builder){
    MaterialPageRoute<void>(
      settings: settings,
      builder: builder
    );
  }
}

/*Back to the project, before testing your login screen, please make sure you’re not ignoring the following settings:
For the Android platform, you must specify the SHA-1 fingerprint in the Firebase console
For the iOS platform, you have to add a custom URL scheme to the Xcode project
For the Web platform, add a meta tag like <meta name="google-signin-client_id" content="{web_client_id}"> to web/index.html, you can find the Web client id in the ‘OAuth 2.0 Client IDs’ section of your project’s credentials page in the Google Cloud console
*/
