import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_app/models/matches/match_manager.dart';
import 'package:soccer_app/models/matches/season.dart';

class CustomModalSelectSeason extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      color: Colors.white,
      child: Column(
        children: [
          _buildHeaderModal(context, "Select a season"),
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

    return Consumer<MatchManager>(
      builder: (_, matchManager, __) {
        final currentSeason = context.read<MatchManager>().currentSeason;
        final seasons = context.read<MatchManager>().seasons;

        return Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: seasons.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildSeasonsOptions(seasons[index], context, isCurrent: seasons[index].seasonId == currentSeason.seasonId);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildSeasonsOptions(Season season, BuildContext context, { bool isCurrent = false}) {
    return InkWell(
      onTap: () {
        context.read<MatchManager>().changeCurrentSeason(season);
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.only(top: 6),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.width * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isCurrent ? Colors.grey[300] : Colors.white,
        ),
        child: Text(
          '${season.name}',
          style: TextStyle(
              color: isCurrent ? Theme.of(context).primaryColor : Colors.grey,
              fontSize: MediaQuery.of(context).size.width * 0.04,
              fontWeight: FontWeight.w900),
        ),

      ),
    );
  }

}
