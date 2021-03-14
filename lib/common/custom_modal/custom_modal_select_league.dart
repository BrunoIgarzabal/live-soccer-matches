import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_app/models/countries/country.dart';
import 'package:soccer_app/models/countries/country_manager.dart';
import 'package:soccer_app/models/leagues/league_manager.dart';

class CustomModalSelectLeague extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 500,
      child: Column(
        children: [
          _buildHeaderModal(context, "Select a championship"),
          _buildContentModal(context)
        ],
      ),
    );
  }

  Widget _buildHeaderModal(BuildContext context, String label) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300], width: 1)
        ),
      ),
      child: Row(
        children: [
          Expanded(child: Container()),
          Expanded(
            flex: 2,
            child: Text(label,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.bold
              ), textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                padding: EdgeInsets.all(5),
                icon: Icon(Icons.close, color: Colors.grey[500]),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContentModal(BuildContext context) {
    final countries = context.read<CountryManager>().allCountries;

    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: countries.length,
          itemBuilder: (BuildContext context, int index) {
            CustomTile tile = CustomTile(countries[index].query.continent, true, false, null, null);

            return _buildChampionshipsList(tile, context);
          },
        ),
      ),
    );
  }

  Widget _buildChampionshipsList(CustomTile tile, BuildContext context) {

    return Consumer<CountryManager>(
      builder: (_, countryManager, __) {

        Country countryAux = countryManager
              .allCountries.firstWhere((element) => element.query.continent == tile.title, orElse: () => null);

        tile.children = countryAux?.results != null ?
            countryAux.results.map((subElement) =>
              CustomTile(subElement.name, false, true, subElement.id.toString(), null/*,
                  (countryManager.allLeagues.
                    where((element) => element.countryId.toString() == subElement.id.toString())).toList()
                    .map((e) => CustomTile(e.name, false, false, null, e.leagueId.toString())).toList()*/)
            ).toList() : null;

        if (context.read<LeagueManager>().loading) {
          return Consumer<LeagueManager>(
            builder: (_, leagueManager, __) {
              return  _buildLeaguesList(tile.title);
            },
          );
        }
        /*if (tile.children != null) {
          tile.children.removeAt(0);
        }*/

        return ExpansionTile(
          key: PageStorageKey<CustomTile>(tile),
          maintainState: false,
          onExpansionChanged: (bool isPressed) {
            if (isPressed) {
              if (tile.isContinent) {
                countryManager.getAllCountriesByContinent(continentName(tile.title));
              } else if (tile.isCountry) {
                //countryManager.getAllLeaguesByCountryId(tile.countryId);
                context.read<LeagueManager>().getAllLeaguesByCountryId(tile.countryId);
              }
            }

          },
          title: Padding(
            padding: EdgeInsets.only(left: tile.isContinent ? 0 : 15),
            child: Text(tile.title, style: TextStyle(
                fontSize: tile.isContinent ? 20 : 18,
                fontWeight: tile.isContinent ? FontWeight.bold : FontWeight.w400,
                color: tile.isContinent ? Colors.black : Colors.grey[800]
            ),),
          ),
          children: tile.children == null || countryManager.loading?
            [Container(
              width: double.infinity,
              height: 5,
              child: LinearProgressIndicator(),
            )] :
            tile.children.map((e) => _buildChampionshipsList(e, context)).toList(),
        );
      },
    );

  }

  Widget _buildLeaguesList(String text) {
    return ListTile(
      enabled: true,
      isThreeLine: false,
      title: Text(text),
      onTap: () {
      },
    );
    /*if ((tile.children == null || tile.children.length == 0) && !tile.isCountry && !tile.isContinent) {
      return ListTile(
        enabled: true,
        isThreeLine: false,
        title: Text(tile.title),
        onTap: () {
        },
      );
    }*/
  }

  Continents continentName(String name) {
    switch (name) {
      case 'Africa': return Continents.africa;
      case 'Asia': return Continents.asia;
      case 'Europe': return Continents.europe;
      case 'Oceania': return Continents.oceania;
      case 'North America': return Continents.northAmerica;
      case 'South America': return Continents.southAmerica;
    }
  }

}

class CustomTile {
  String title;
  bool isContinent;
  bool isCountry;
  List<CustomTile> children;

  String countryId;
  String leagueId;

  CustomTile(
    this.title,
    this.isContinent,
    this.isCountry,
    this.countryId,
    this.leagueId,
    [this.children = const <CustomTile>[]]
  );
}
