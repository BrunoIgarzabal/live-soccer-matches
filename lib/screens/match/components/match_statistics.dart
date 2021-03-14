import 'package:flutter/material.dart';
import 'package:soccer_app/models/matches/match_detail.dart';

class MatchStatisticsWidget extends StatelessWidget {

  final MatchDetail matchDetail;

  const MatchStatisticsWidget(this.matchDetail);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      ],
    );
  }

  Widget _buildLineInfoStatistics(int value1, value2, String label) {
    return Row(
      children: [
        Expanded(child: Text('$value1')),
        Expanded(child: Text(label)),
        Expanded(child: Expanded(child: Text('$value1')),),
      ],
    );
  }
}
