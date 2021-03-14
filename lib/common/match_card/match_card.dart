import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soccer_app/models/matches/match.dart';

import 'package:provider/provider.dart';
import 'package:soccer_app/models/matches/match_manager.dart';

class MatchCard extends StatelessWidget {

  final Match match;

  const MatchCard(this.match);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<MatchManager>().currentMatch = null;
        Navigator.of(context).pushNamed(
          '/match_details',
          arguments: match.matchId
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 130,
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.grey[200])
          ),
        ),
        child: Column(
          children: [
            _buildLineInfoMatch(),
            _buildLineScoresMatch(context),
            _buildLineTeamNames(context)
          ],
        ),
      ),
    );
  }

  Widget _buildLineInfoMatch() {
    return Container(
      margin: const EdgeInsets.only(top: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(child: Text(dateFormatted(match.matchStart), style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11
          ), textAlign: TextAlign.center,)),
          Expanded(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.red
                ),
              ),
              Text(statusMatch(match.statusCode), style: TextStyle(
              ), textAlign: TextAlign.center)
            ],
          )),
          Expanded(child: Text(dateFormatted(match.matchStart, isHour: true), style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11
          ), textAlign: TextAlign.center),),
        ],
      ),
    );
  }
  
  Widget _buildLineScoresMatch(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 7),
      child: Row(
        children: [
          Expanded(
            flex: 2,
              child: match?.homeTeam?.logo != null ?
                Image.network(match.homeTeam.logo, width: 45, height: 45,) :
                Image.asset('assets/images/team_flag.pnh')
          ),
          Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Text('${match.stats.homeScore}', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: match.stats.homeScore > match.stats.awayScore ?
                      Theme.of(context).primaryColor : Colors.grey
                  ),)),
                  Expanded(child: Text('x')),
                  Expanded(child: Text('${match.stats.awayScore}', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: match.stats.awayScore > match.stats.homeScore ?
                      Theme.of(context).primaryColor : Colors.grey
                  ))),
                ],
              )
          ),
          Expanded(
              flex: 2,
              child: match?.awayTeam?.logo != null ?
              Image.network(match.awayTeam.logo, width: 45, height: 45,) :
              Image.asset('assets/images/team_flag.pnh')
          ),
        ],
      ),
    );
  }

  Widget _buildLineTeamNames(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 7),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(match?.homeTeam?.name ?? '', style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold
            ), textAlign: TextAlign.center,),
          ),
          Expanded(
            child: Container(),
          ),
          Expanded(
            flex: 2,
            child: Text(match?.awayTeam?.name ?? '', style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold
            ), textAlign: TextAlign.center,),
          )
        ],
      ),
    );
  }

  String statusMatch(int status) {
    switch (status) {
      case 0: return 'Not Started';
      case 1: return 'In play';
      case 11: return 'Half-time';
      case 12: return 'Extra-time';
      case 13: return 'Penalties';
      case 14: return 'Break-time';
      case 3: return 'Finished';
      case 31: return 'After penalties';
      case 32: return 'After Extra-time';
      case 4: return 'Postponed';
      case 5: return 'Cancelled';
      case 6: return 'Abandoned';
      case 7: return 'Interrupted';
      case 8: return 'Suspended';
      case 9: return 'Awarded';
      case 10: return 'Delayed';
      case 17: return 'To be announced';
    }
  }

  String dateFormatted(String date, { isHour = false}) {
    return DateFormat(isHour ? 'HH:mm' : 'MM.dd.yyyy').format(DateTime.parse(date));
  }
}
