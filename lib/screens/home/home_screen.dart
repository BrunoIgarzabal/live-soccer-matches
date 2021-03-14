import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soccer_app/common/custom_drawer/custom_drawer.dart';
import 'package:soccer_app/common/custom_modal/custom_modal_select_league.dart';
import 'package:soccer_app/common/custom_modal/custom_modal_select_season.dart';
import 'package:soccer_app/common/match_card/match_card.dart';
import 'package:soccer_app/models/leagues/league_manager.dart';
import 'package:soccer_app/models/matches/match_manager.dart';

import 'components/search_dialog.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text("Home", style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () async {
            final search = await showDialog<String>(context: context,
                builder: (_) => SearchDialog(''));
          })
        ],
      ),
      body: Consumer<MatchManager>(
        builder: (_, matchManager, __) {

          return ListView(
            children: [
              _buildTitleCurrentChampionship(context),
              _buildSelectOtherChampionshipButton(context),
              //_buildSelectSeason(context, matchManager),
              _buildListMatches(context, matchManager)
            ],
          );
        },
      ),
    );
  }

  Widget _buildTitleCurrentChampionship(BuildContext context) {
    //final league = context.read<LeagueManager>().currentLeague;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 15,
          height: 15,
          margin: const EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.red
          ),
        ),
        Container(
          padding: const EdgeInsets.all(14),
          child: Text('Live matches', style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20
          ),),
        )
      ],
    );
  }

  Widget _buildSelectOtherChampionshipButton(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(child: InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Other competitions", style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ), textAlign: TextAlign.center,),
                Container(width: 10,),
                Icon(Icons.keyboard_arrow_down, color: Colors.white, )
              ],
            ),
            onTap: () {
              _openCustomModalSelectLeague(context);
            },
          ))
        ],
      ),
    );
  }

  void _openCustomModalSelectLeague(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return CustomModalSelectLeague();
      });
  }

  Widget _buildSelectSeason(BuildContext context, MatchManager matchManager) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(8),
      ),
      child: Material(
        borderRadius:
        BorderRadius.circular(8),
        color: Colors.grey[300],
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.width * 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                _buildTextInsideSelectBottom(context, matchManager),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            if (matchManager.currentSeason != null) {
              _openCustomModalSelectSeason(context);
            }
          },
        ),
      ),
    );
  }

  void _openCustomModalSelectSeason(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return CustomModalSelectSeason();
        });
  }

  Widget _buildTextInsideSelectBottom(BuildContext context, MatchManager matchManager) {
    return Expanded(
      flex: 7,
      child: matchManager.currentSeason != null ? Text(
        'Season ${matchManager.currentSeason.name}',
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: MediaQuery.of(context).size.width * 0.04,
            fontWeight: FontWeight.w900),
        textAlign: TextAlign.center,
      ) : Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[100],
        child: Container(
          width: 48.0,
          height: 48.0,
          color: Colors.white,
        ),
      )
    );
  }


  Widget _buildListMatches(BuildContext context, MatchManager matchManager) {

    final matches = matchManager.matches;

    return matches == null ? ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[200],
            highlightColor: Colors.grey[50],
            child: Container(
              width: 48.0,
              height: 48.0,
              color: Colors.white,
            ),
          ),
        );
      },
    ) : matches.length != 0 ? ListView.builder(
        itemCount: matches.length,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return MatchCard(matches[index]);
        }
    ) : Container(
      margin: const EdgeInsets.only(top: 30),
      child: Center(
        child: Text('No Live Matches', style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22
        ),),
      ),
    );
  }

}
