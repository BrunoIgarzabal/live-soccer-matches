import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soccer_app/models/matches/match_detail.dart';
import 'package:soccer_app/models/matches/match_manager.dart';

class MatchDetails extends StatefulWidget {

  final matchId;

  const MatchDetails(this.matchId);

  @override
  _MatchDetailsState createState() => _MatchDetailsState();
}

class _MatchDetailsState extends State<MatchDetails> {

  MatchDetail match;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    await context.read<MatchManager>().getMatchById(widget.matchId);

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MatchManager>(
      builder: (_, matchManager, __) {
        match = matchManager.currentMatch;
        return DefaultTabController(
          length: 1,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Match Details'),
              centerTitle: true,
              elevation: 0,
            ),
            body: matchManager.currentMatch != null ? Column(
              children: [
                Container(
                  color: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      _buildLineScoresMatch(),
                      _buildLineTeamNames(),
                    ],
                  ),
                ),
                _buildTabs()
              ],
            ) : ListView.builder(
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
            ),
          ),
        );
      },
    );
  }


  Widget _buildLineScoresMatch() {
    int homeScore = int.parse(/*match.stats.htScore.split('-')[0] ??*/  match.stats.ftScore.split('-')[0]);
    int awayScore = int.parse(/*match.stats.htScore.split('-')[1] ??*/ match.stats.ftScore.split('-')[1]);

    return Container(
      margin: const EdgeInsets.only(top: 7),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: match?.homeTeam?.logo != null ?
              Image.network(match.homeTeam.logo, width: 60, height: 60,) :
              Image.asset('assets/images/team_flag.pnh')
          ),
          Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Text('$homeScore', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      color: Colors.white
                  ),)),
                  Expanded(child: Text(':', style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32
                  ), textAlign: TextAlign.center,)),
                  Expanded(child: Text('$awayScore', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      color: Colors.white
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

  Widget _buildLineTeamNames() {
    return Container(
      margin: const EdgeInsets.only(top: 7),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(match?.homeTeam?.name ?? '', style: TextStyle(
                fontSize: 13,
                color: Colors.white,
            ), textAlign: TextAlign.center,),
          ),
          Expanded(
            child: Container(),
          ),
          Expanded(
            flex: 2,
            child: Text(match?.awayTeam?.name ?? '', style: TextStyle(
                fontSize: 13,
                color: Colors.white,
            ), textAlign: TextAlign.center,),
          )
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: double.infinity,
            height: 50,
            child: AppBar(
              elevation: 0,
              bottom: TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tab(
                    text: 'MATCH EVENTS',
                  ),
                  /*Tab(
                    text: 'STATISTICS',
                  ),*/
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildMatchEvent()
                //MatchStatisticsWidget(match)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchEvent() {
    return ListView.builder(
      itemCount: match.matchEvents.length,
      itemBuilder: (context, index) {
        return _buildMatchEventDetail(match.matchEvents[index]);
      },
    );
  }

  Widget _buildMatchEventDetail(MatchEvents events) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 60,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200], width: 1)
        )
      ),
      child: events.type == 'Start the match' ?
        _buildLineHomeTeam(events, isStartGame: true) :
        events.teamId == match.homeTeam.teamId ?
          _buildLineHomeTeam(events) :
          _buildLineAwayTeam(events)
    );
  }

  Widget _buildLineHomeTeam(MatchEvents events, { isStartGame = false}) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: Text('${events.minute < 0 ? 0 : events.minute}\'', style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),)),
        if (isStartGame)
          SizedBox(
            width: 40,
            child: Icon(Icons.sports_soccer, color: Colors.grey,),
          ),
        if (!isStartGame)
          Container(
            width: 20,
            margin: const EdgeInsets.only(right: 10),
            child: _buildIconEvent(events.type)),

        if (events.type != 'substitution' && !isStartGame)
          Text(events.playerName ?? '', style: TextStyle(
              color: Colors.grey
          ),),
        if (events.type != 'substitution' && isStartGame)
          Text(events.type ?? '', style: TextStyle(
              color: Colors.grey
          ),),
        if (events.type == 'substitution')
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(events.relatedPlayerName ?? '', style: TextStyle(
                  color: Colors.green,
                  fontSize: 15,
                ),),
                Text(events.playerName ?? '', style: TextStyle(
                  color: Colors.red,
                  fontSize: 15,
                ),),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildLineAwayTeam(MatchEvents events) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (events.type != 'substitution')
          Text(events.playerName ?? '', style: TextStyle(
              color: Colors.grey
          ),),
        if (events.type == 'substitution')
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(events.relatedPlayerName ?? '', style: TextStyle(
                  color: Colors.green,
                  fontSize: 15,
                ),),
                Text(events.playerName ?? '', style: TextStyle(
                  color: Colors.red,
                  fontSize: 15,
                ),),
              ],
            ),
          ),

        Container(
          width: 20,
          margin: const EdgeInsets.only(right: 10, left: 10),
          child: _buildIconEvent(events.type)),
        Container(
            margin: const EdgeInsets.only(right: 20),
            child: Text('${events.minute < 0 ? 0 : events.minute}\'', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
            ),)),
      ],
    );
  }

  Widget _buildIconEvent(String event) {
    switch (event) {
      case 'yellowcard':
        return Image.asset('assets/images/yellow_card.png', width: 20,);
      case 'redcard':
        return Image.asset('assets/images/red_card.png', width: 20,);
      case 'yellowredcard':
        return Image.asset('assets/images/yellow_red_card.png', width: 20,);
      case 'goal':
        return Icon(Icons.sports_soccer, color: Colors.grey,);
      case 'injury':
        return Image.asset('assets/images/injury.png', width: 20,);
      case 'back from injury':
        return Icon(Icons.arrow_back, color: Colors.green,);
      case 'substitution':
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back, color: Colors.green, size: 18,),
              Icon(Icons.arrow_forward, color: Colors.red, size: 18,),
            ],
          ),
        );
      default:
        return Text(event);
    }
  }


}
