import 'package:flutter/material.dart';
import 'package:soccer_app/services/sportdata_service.dart';

import 'country.dart';

class CountryManager extends ChangeNotifier {

  CountryManager() {
    allCountries.add(Country(query: Query(continent: 'Africa')));
    allCountries.add(Country(query: Query(continent: 'Asia')));
    allCountries.add(Country(query: Query(continent: 'Europe')));
    allCountries.add(Country(query: Query(continent: 'Oceania')));
    allCountries.add(Country(query: Query(continent: 'North America')));
    allCountries.add(Country(query: Query(continent: 'South America')));

     sportDataService = SportDataService();

  }
  SportDataService sportDataService;

  List<Country> allCountries = List<Country>();

  bool loading = false;

  Future<void> getAllCountriesByContinent(Continents continent) async {
    var continentIndex = allCountries.indexWhere((element) => element.query.continent == continent.name);

    if (allCountries[continentIndex].results != null) {
      return;
    }

    loading = true;

    try {
      Country country = await sportDataService.getCountriesByContinent(continent);
      allCountries[continentIndex].results = [... country.results];

      loading = false;

    } catch (e) {
      return Future.error("Error occurred while returning data: " + e.toString());
    }

    notifyListeners();
  }


}