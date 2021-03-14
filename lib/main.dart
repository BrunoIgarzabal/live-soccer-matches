import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_app/models/matches/match_manager.dart';
import 'package:soccer_app/screens/base/base_screen.dart';
import 'package:soccer_app/screens/match/match_detail.dart';

import 'models/countries/country_manager.dart';
import 'models/leagues/league_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CountryManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => LeagueManager(),
          lazy: false,
        ),
        /*,
        ChangeNotifierProvider(
          create: (context) => MatchManager(context.read<LeagueManager>().currentLeague),
          lazy: true,
        ),
        */
        ChangeNotifierProvider(
          create: (context) => MatchManager(),
          lazy: true,
        ),
      ],
      child: MaterialApp(
        title: 'TREX App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromRGBO(0, 77, 157, 1),
          accentColor: Color.fromRGBO(0, 97, 197, 1),
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/match_details':
              return MaterialPageRoute(
                builder: (_) => MatchDetails(
                  settings.arguments as int
                ),
              );
            case '/':
            default:
              return MaterialPageRoute(
                builder: (_) => BaseScreen(),
                settings: settings
              );
          }
        },
      ),
    );
  }
}


