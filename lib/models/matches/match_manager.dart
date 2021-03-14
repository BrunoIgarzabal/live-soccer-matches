import 'package:flutter/material.dart';
import 'package:soccer_app/models/leagues/league.dart';
import 'package:soccer_app/models/matches/match.dart';
import 'package:soccer_app/models/matches/match_detail.dart';
import 'package:soccer_app/services/sportdata_service.dart';

import 'season.dart';

class MatchManager extends ChangeNotifier {

  MatchManager() {
    sportDataService = SportDataService();

    getAllLiveMatches();
  }

  Season currentSeason;

  void changeCurrentSeason(Season season) {
    if (currentSeason.seasonId != season.seasonId) {
      currentSeason = season;
      matches = [];
      _getMatchesByCurrentSeason();
      notifyListeners();
    }

  }

  List<Season> seasons = List<Season>();
  List<Match> matches;

  MatchDetail currentMatch;

  SportDataService sportDataService;
  bool loading = false;

  Future<void> getAllSeasonsByLeagueId(String leagueId) async {
    try {
      List<Season> allSeasonsByLeague = await sportDataService.getSeasonsByLeagueId(leagueId);
      seasons = allSeasonsByLeague;
      currentSeason = seasons.firstWhere((element) => element.isCurrent == 1);
    } catch (e) {
      return Future.error("Error occurred while returning data: " + e.toString());
    }

    notifyListeners();
  }

  Future<void> getAllLiveMatches() async {
    try {
      List<Match> allMatchesBySeason = await sportDataService.getLiveMatchs();
      matches = allMatchesBySeason ?? [];
      if (matches != null && matches.length != 0) {
        matches.removeWhere((element) => element.awayTeam == null && element.homeTeam == null);
      }


    } catch (e) {
      return Future.error("Error occurred while returning live matches: " + e.toString());
    }

    notifyListeners();
  }

  Future<void> _getMatchesByCurrentSeason() async {
    try {
      List<Match> allMatchesBySeason = await sportDataService.getMatchsBySeasonId(currentSeason.seasonId.toString());
      matches = allMatchesBySeason.take(20).toList() ?? [];

      print(matches.length);
    } catch (e) {
      return Future.error("Error occurred while returning data: " + e.toString());
    }

    notifyListeners();
  }

  Future<void> getMatchById(int id) async {
    currentMatch = null;
    print(id);

    try {
      currentMatch = await sportDataService.getMatchById(id);

      if (currentMatch.matchEvents == null) {
        currentMatch.matchEvents = [MatchEvents(
            minute: 0,
            type: 'Start the match'
        )];
      } else {
        currentMatch.matchEvents.sort((a, b) => b.minute.compareTo(a.minute));
        currentMatch.matchEvents.add(MatchEvents(
            minute: 0,
            type: 'Start the match'
        ));
      }

      notifyListeners();
    } catch (e) {
      return Future.error("Error occurred while returning data: " + e.toString());
    }
  }

}