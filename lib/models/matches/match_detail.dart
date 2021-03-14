class MatchDetail {
  int matchId;
  int leagueId;
  Round round;
  int refereeId;
  int seasonId;
  Stage stage;
  int statusCode;
  String matchStart;
  String matchStartIso;
  int minute;
  String status;
  Stats stats;
  HomeTeam homeTeam;
  HomeTeam awayTeam;
  List<MatchEvents> matchEvents;
  List<MatchStatistics> matchStatistics;
  List<Lineups> lineups;
  Venue venue;

  MatchDetail(
      {this.matchId,
        this.leagueId,
        this.round,
        this.refereeId,
        this.seasonId,
        this.stage,
        this.statusCode,
        this.matchStart,
        this.matchStartIso,
        this.minute,
        this.status,
        this.stats,
        this.homeTeam,
        this.awayTeam,
        this.matchEvents,
        this.matchStatistics,
        this.lineups,
        this.venue});

  MatchDetail.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'];
    leagueId = json['league_id'];
    round = json['round'] != null ? new Round.fromJson(json['round']) : null;
    refereeId = json['referee_id'];
    seasonId = json['season_id'];
    stage = json['stage'] != null ? new Stage.fromJson(json['stage']) : null;
    statusCode = json['status_code'];
    matchStart = json['match_start'];
    matchStartIso = json['match_start_iso'];
    minute = json['minute'];
    status = json['status'];
    stats = json['stats'] != null ? new Stats.fromJson(json['stats']) : null;
    homeTeam = json['home_team'] != null
        ? new HomeTeam.fromJson(json['home_team'])
        : null;
    awayTeam = json['away_team'] != null
        ? new HomeTeam.fromJson(json['away_team'])
        : null;
    if (json['match_events'] != null) {
      matchEvents = new List<MatchEvents>();
      json['match_events'].forEach((v) {
        matchEvents.add(new MatchEvents.fromJson(v));
      });
    }
    if (json['match_statistics'] != null) {
      matchStatistics = new List<MatchStatistics>();
      json['match_statistics'].forEach((v) {
        matchStatistics.add(new MatchStatistics.fromJson(v));
      });
    }
    if (json['lineups'] != null) {
      lineups = new List<Lineups>();
      json['lineups'].forEach((v) {
        lineups.add(new Lineups.fromJson(v));
      });
    }
    venue = json['venue'] != null ? new Venue.fromJson(json['venue']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_id'] = this.matchId;
    data['league_id'] = this.leagueId;
    if (this.round != null) {
      data['round'] = this.round.toJson();
    }
    data['referee_id'] = this.refereeId;
    data['season_id'] = this.seasonId;
    if (this.stage != null) {
      data['stage'] = this.stage.toJson();
    }
    data['status_code'] = this.statusCode;
    data['match_start'] = this.matchStart;
    data['match_start_iso'] = this.matchStartIso;
    data['minute'] = this.minute;
    data['status'] = this.status;
    if (this.stats != null) {
      data['stats'] = this.stats.toJson();
    }
    if (this.homeTeam != null) {
      data['home_team'] = this.homeTeam.toJson();
    }
    if (this.awayTeam != null) {
      data['away_team'] = this.awayTeam.toJson();
    }
    if (this.matchEvents != null) {
      data['match_events'] = this.matchEvents.map((v) => v.toJson()).toList();
    }
    if (this.matchStatistics != null) {
      data['match_statistics'] =
          this.matchStatistics.map((v) => v.toJson()).toList();
    }
    if (this.lineups != null) {
      data['lineups'] = this.lineups.map((v) => v.toJson()).toList();
    }
    if (this.venue != null) {
      data['venue'] = this.venue.toJson();
    }
    return data;
  }
}

class Round {
  int roundId;
  String name;
  int isCurrent;

  Round({this.roundId, this.name, this.isCurrent});

  Round.fromJson(Map<String, dynamic> json) {
    roundId = json['round_id'];
    name = json['name'];
    isCurrent = json['is_current'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['round_id'] = this.roundId;
    data['name'] = this.name;
    data['is_current'] = this.isCurrent;
    return data;
  }
}

class Stage {
  int stageId;
  String name;

  Stage({this.stageId, this.name});

  Stage.fromJson(Map<String, dynamic> json) {
    stageId = json['stage_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stage_id'] = this.stageId;
    data['name'] = this.name;
    return data;
  }
}

class Stats {
  String ftScore;
  String htScore;

  Stats({this.ftScore, this.htScore});

  Stats.fromJson(Map<String, dynamic> json) {
    ftScore = json['ft_score'];
    htScore = json['ht_score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ft_score'] = this.ftScore;
    data['ht_score'] = this.htScore;
    return data;
  }
}

class HomeTeam {
  int teamId;
  String name;
  String shortCode;
  String commonName;
  String logo;
  CountryDetailMatch country;

  HomeTeam(
      {this.teamId,
        this.name,
        this.shortCode,
        this.commonName,
        this.logo,
        this.country});

  HomeTeam.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'];
    name = json['name'];
    shortCode = json['short_code'];
    commonName = json['common_name'];
    logo = json['logo'];
    country =
    json['country'] != null ? new CountryDetailMatch.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_id'] = this.teamId;
    data['name'] = this.name;
    data['short_code'] = this.shortCode;
    data['common_name'] = this.commonName;
    data['logo'] = this.logo;
    if (this.country != null) {
      data['country'] = this.country.toJson();
    }
    return data;
  }
}

class CountryDetailMatch {
  int countryId;
  String name;
  String countryCode;
  String continent;

  CountryDetailMatch({this.countryId, this.name, this.countryCode, this.continent});

  CountryDetailMatch.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    name = json['name'];
    countryCode = json['country_code'];
    continent = json['continent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_id'] = this.countryId;
    data['name'] = this.name;
    data['country_code'] = this.countryCode;
    data['continent'] = this.continent;
    return data;
  }
}

class MatchEvents {
  int teamId;
  String type;
  int playerId;
  String playerName;
  String relatedPlayerName;
  int minute;
  String injured;
  bool ownGoal;
  bool penalty;
  String result;

  MatchEvents(
      {this.teamId,
        this.type,
        this.playerId,
        this.playerName,
        this.minute,
        this.relatedPlayerName,
        this.injured,
        this.ownGoal,
        this.penalty,
        this.result});

  MatchEvents.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'];
    type = json['type'];
    playerId = json['player_id'];
    playerName = json['player_name'];
    relatedPlayerName = json['related_player_name'];
    minute = json['minute'];
    injured = json['injured'];
    ownGoal = json['own_goal'];
    penalty = json['penalty'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_id'] = this.teamId;
    data['type'] = this.type;
    data['player_id'] = this.playerId;
    data['player_name'] = this.playerName;
    data['related_player_name'] = this.relatedPlayerName;
    data['minute'] = this.minute;
    data['injured'] = this.injured;
    data['own_goal'] = this.ownGoal;
    data['penalty'] = this.penalty;
    data['result'] = this.result;
    return data;
  }
}

class MatchStatistics {
  int teamId;
  String teamName;
  int fouls;
  int injuries;
  int corners;
  int offsides;
  int shotsTotal;
  int shotsOnTarget;
  int shotsOffTarget;
  int shotsBlocked;
  int possessiontime;
  int possessionpercent;
  int yellowcards;
  int yellowredcards;
  int redcards;
  int substitutions;
  int goalKick;
  int goalAttempts;
  int freeKick;
  int throwIn;
  int ballSafe;
  int goals;
  int penalties;
  int attacks;
  int dangerousAttacks;

  MatchStatistics(
      {this.teamId,
        this.teamName,
        this.fouls,
        this.injuries,
        this.corners,
        this.offsides,
        this.shotsTotal,
        this.shotsOnTarget,
        this.shotsOffTarget,
        this.shotsBlocked,
        this.possessiontime,
        this.possessionpercent,
        this.yellowcards,
        this.yellowredcards,
        this.redcards,
        this.substitutions,
        this.goalKick,
        this.goalAttempts,
        this.freeKick,
        this.throwIn,
        this.ballSafe,
        this.goals,
        this.penalties,
        this.attacks,
        this.dangerousAttacks});

  MatchStatistics.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'];
    teamName = json['team_name'];
    fouls = json['fouls'];
    injuries = json['injuries'];
    corners = json['corners'];
    offsides = json['offsides'];
    shotsTotal = json['shots_total'];
    shotsOnTarget = json['shots_on_target'];
    shotsOffTarget = json['shots_off_target'];
    shotsBlocked = json['shots_blocked'];
    possessiontime = json['possessiontime'];
    possessionpercent = json['possessionpercent'];
    yellowcards = json['yellowcards'];
    yellowredcards = json['yellowredcards'];
    redcards = json['redcards'];
    substitutions = json['substitutions'];
    goalKick = json['goal_kick'];
    goalAttempts = json['goal_attempts'];
    freeKick = json['free_kick'];
    throwIn = json['throw_in'];
    ballSafe = json['ball_safe'];
    goals = json['goals'];
    penalties = json['penalties'];
    attacks = json['attacks'];
    dangerousAttacks = json['dangerous_attacks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_id'] = this.teamId;
    data['team_name'] = this.teamName;
    data['fouls'] = this.fouls;
    data['injuries'] = this.injuries;
    data['corners'] = this.corners;
    data['offsides'] = this.offsides;
    data['shots_total'] = this.shotsTotal;
    data['shots_on_target'] = this.shotsOnTarget;
    data['shots_off_target'] = this.shotsOffTarget;
    data['shots_blocked'] = this.shotsBlocked;
    data['possessiontime'] = this.possessiontime;
    data['possessionpercent'] = this.possessionpercent;
    data['yellowcards'] = this.yellowcards;
    data['yellowredcards'] = this.yellowredcards;
    data['redcards'] = this.redcards;
    data['substitutions'] = this.substitutions;
    data['goal_kick'] = this.goalKick;
    data['goal_attempts'] = this.goalAttempts;
    data['free_kick'] = this.freeKick;
    data['throw_in'] = this.throwIn;
    data['ball_safe'] = this.ballSafe;
    data['goals'] = this.goals;
    data['penalties'] = this.penalties;
    data['attacks'] = this.attacks;
    data['dangerous_attacks'] = this.dangerousAttacks;
    return data;
  }
}

class Lineups {
  int teamId;
  int formationConfirmed;
  List<Players> players;

  Lineups({this.teamId, this.formationConfirmed, this.players});

  Lineups.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'];
    formationConfirmed = json['formation_confirmed'];
    if (json['players'] != null) {
      players = new List<Players>();
      json['players'].forEach((v) {
        players.add(new Players.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_id'] = this.teamId;
    data['formation_confirmed'] = this.formationConfirmed;
    if (this.players != null) {
      data['players'] = this.players.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Players {
  int playerId;
  String firstname;
  String lastname;
  String birthday;
  int age;
  int weight;
  int height;
  String img;
  CountryDetailMatch country;
  Detailed detailed;

  Players(
      {this.playerId,
        this.firstname,
        this.lastname,
        this.birthday,
        this.age,
        this.weight,
        this.height,
        this.img,
        this.country,
        this.detailed});

  Players.fromJson(Map<String, dynamic> json) {
    playerId = json['player_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    birthday = json['birthday'];
    age = json['age'];
    weight = json['weight'];
    height = json['height'];
    img = json['img'];
    country =
    json['country'] != null ? new CountryDetailMatch.fromJson(json['country']) : null;
    detailed = json['detailed'] != null
        ? new Detailed.fromJson(json['detailed'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player_id'] = this.playerId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['birthday'] = this.birthday;
    data['age'] = this.age;
    data['weight'] = this.weight;
    data['height'] = this.height;
    data['img'] = this.img;
    if (this.country != null) {
      data['country'] = this.country.toJson();
    }
    if (this.detailed != null) {
      data['detailed'] = this.detailed.toJson();
    }
    return data;
  }
}

class Detailed {
  int number;
  String position;

  Detailed({this.number, this.position});

  Detailed.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['position'] = this.position;
    return data;
  }
}

class Venue {
  int venueId;
  String name;
  int capacity;
  String city;
  int countryId;

  Venue({this.venueId, this.name, this.capacity, this.city, this.countryId});

  Venue.fromJson(Map<String, dynamic> json) {
    venueId = json['venue_id'];
    name = json['name'];
    capacity = json['capacity'];
    city = json['city'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['venue_id'] = this.venueId;
    data['name'] = this.name;
    data['capacity'] = this.capacity;
    data['city'] = this.city;
    data['country_id'] = this.countryId;
    return data;
  }
}