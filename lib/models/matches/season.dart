class Season {
  int seasonId;
  String name;
  int isCurrent;
  int countryId;
  int leagueId;
  String startDate;
  String endDate;

  Season(
      {this.seasonId,
        this.name,
        this.isCurrent,
        this.countryId,
        this.leagueId,
        this.startDate,
        this.endDate});

  Season.fromJson(Map<String, dynamic> json) {
    seasonId = json['season_id'];
    name = json['name'];
    isCurrent = json['is_current'];
    countryId = json['country_id'];
    leagueId = json['league_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['season_id'] = this.seasonId;
    data['name'] = this.name;
    data['is_current'] = this.isCurrent;
    data['country_id'] = this.countryId;
    data['league_id'] = this.leagueId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}