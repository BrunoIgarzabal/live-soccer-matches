import 'package:flutter/material.dart';
import 'package:soccer_app/services/sportdata_service.dart';

import '../leagues/league.dart';

class LeagueManager extends ChangeNotifier {
  List<League> allLeagues = List<League>();

  League currentLeague;

  SportDataService sportDataService;
  bool loading = false;

  LeagueManager() {
    sportDataService = SportDataService();
    currentLeague = League(leagueId: 283, name: 'UEFA Champions League');
  }

  Future<void> getAllLeaguesByCountryId(String countryId) async {
    loading = true;

    var leaguesAux = allLeagues?.indexWhere((element) => element.countryId.toString() == countryId);

    if (leaguesAux != -1) {
      return;
    }

    try {
      List<League> leagues = await sportDataService.getLeaguesByCountryId(countryId);
      allLeagues = [...leagues];

      print(allLeagues.length);
      loading = false;
    } catch (e) {
      return Future.error("Error occurred while returning data: " + e.toString());
    }

    notifyListeners();

  }

}