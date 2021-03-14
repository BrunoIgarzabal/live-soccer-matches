class League {
  int leagueId;
  int countryId;
  String name;

  League({this.leagueId, this.countryId, this.name});

  League.fromJson(Map<String, dynamic> json) {
    leagueId = json['league_id'];
    countryId = json['country_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['league_id'] = this.leagueId;
    data['country_id'] = this.countryId;
    data['name'] = this.name;
    return data;
  }
}