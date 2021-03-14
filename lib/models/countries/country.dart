import 'package:flutter/material.dart';

enum Continents { africa, asia, europe, oceania, northAmerica, southAmerica }

extension ContinentsExtension on Continents {
  String get name {
    switch (this) {
      case Continents.africa: return 'Africa';
      case Continents.asia: return 'Asia';
      case Continents.europe: return 'Europe';
      case Continents.oceania: return 'Oceania';
      case Continents.northAmerica: return 'North America';
      case Continents.southAmerica: return 'South America';
    }
  }
}


class Country {
  Query query;
  List<Results> results;

  Country({this.query, this.results});

  Country.fromJson(Map<String, dynamic> json) {
    query = json['query'] != null ? new Query.fromJson(json['query']) : null;
    if (json['data'] != null) {
      results = new List<Results>();

      json['data'].forEach((key, value) {
        results.add(new Results.fromJson(value));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.query != null) {
      data['query'] = this.query.toJson();
    }
    if (this.results != null) {
      data['data'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Query {
  String continent;

  Query({this.continent});

  Query.fromJson(Map<String, dynamic> json) {
    continent = json['continent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['continent'] = this.continent;
    return data;
  }
}

class Results {
  int id;
  String name;
  String countryCode;
  String continent;

  Results({this.id, this.name, this.countryCode, this.continent});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['country_id'];
    name = json['name'];
    countryCode = json['country_code'];
    continent = json['continent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_id'] = this.id;
    data['name'] = this.name;
    data['country_code'] = this.countryCode;
    data['continent'] = this.continent;
    return data;
  }
}