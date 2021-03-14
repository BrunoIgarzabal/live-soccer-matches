
import 'package:dio/dio.dart';
import 'package:soccer_app/models/leagues/league.dart';
import 'package:soccer_app/models/matches/match.dart';
import 'package:soccer_app/models/matches/match_detail.dart';
import 'package:soccer_app/models/matches/season.dart';

import '../models/countries/country.dart';

const apiKey = '';

class SportDataService {
  Dio dio;
  String endpoint = 'https://app.sportdataapi.com/api/v1/soccer';

  SportDataService() {
    dio = Dio();
    //dio.options.queryParameters["apiKey"] = apiKey;
  }

  Future<Country> getCountriesByContinent(Continents continent) async {
    //dio.options.queryParameters["continent"] = continent.name;
    String url = '$endpoint/countries?apikey=$apiKey&continent=${continent.name}';

    final response = await dio.get<Map<String, dynamic>>(url);

    if (response.data.isEmpty) {
      return Future.error('An error occurred while returning countries datas');
    }

    final Country country = Country.fromJson(response.data);
    return country;

  }

  Future<List<League>> getLeaguesByCountryId(String countryId) async {
    String url = '$endpoint/leagues?apikey=$apiKey&country_id=$countryId';

    final response = await dio.get<Map<String, dynamic>>(url);

    if (response.data.isEmpty) {
      return Future.error('An error occurred while returning leagues data');
    }

    List<League> leagues = List<League>();

    response.data['data'].forEach((key, value)  {
      leagues.add(League.fromJson(value));
    });

    return leagues;

  }

  Future<List<Season>> getSeasonsByLeagueId(String leagueId) async {
    leagueId = "281";
    String url = '$endpoint/seasons?apikey=$apiKey&league_id=$leagueId';

    final response = await dio.get<Map<String, dynamic>>(url);

    if (response.data.isEmpty) {
      return Future.error('An error occurred while returning seasons data');
    }

    List<Season> seasons = List<Season>();

    response.data['data'].forEach((value) {
      seasons.add(Season.fromJson(value));
    });

    /*response.data.forEach((key, value)  {
      seasons.add(Season.fromJson(value));
    });*/

    return seasons;
  }

  Future<List<Match>> getLiveMatchs() async {
    String url = '$endpoint/matches?apikey=$apiKey&live=${true}';

    final response = await dio.get<Map<String, dynamic>>(url);

    if (response.data.isEmpty) {
      return Future.error('An error occurred while returning matches data');
    }

    List<Match> matches = List<Match>();

    response.data['data'].forEach((value) {
      matches.add(Match.fromJson(value));
    });

    return matches;
  }

  Future<List<Match>> getMatchsBySeasonId(String seasonId) async {
    String url = '$endpoint/matches?apikey=$apiKey&season_id=$seasonId';

    final response = await dio.get<Map<String, dynamic>>(url);

    if (response.data.isEmpty) {
      return Future.error('An error occurred while returning leagues data');
    }

    List<Match> matches = List<Match>();

    response.data['data'].forEach((value) {
      matches.add(Match.fromJson(value));
    });

    return matches;
  }

  Future<MatchDetail> getMatchById(int id) async {
    String url = '$endpoint/matches/$id?apikey=$apiKey';

    final response = await dio.get<Map<String, dynamic>>(url);

    if (response.data.isEmpty) {
      return Future.error('An error occurred while returning match data');
    }

    final match = MatchDetail.fromJson(response.data['data']);

    return match;
  }

}
