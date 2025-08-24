import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class AssignmentPage2 extends StatefulWidget {
  final String docid;
  const AssignmentPage2({super.key, required this.docid});

  @override
  State<AssignmentPage2> createState() => _AssignmentPage2State();
}

class _AssignmentPage2State extends State<AssignmentPage2> {

  final Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  String _display = '00:00:00';

  void _start() {
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (_) {
      setState(() {
        final el = _stopwatch.elapsed;
        _display = '${el.inHours.toString().padLeft(2, '0')}:'
            '${(el.inMinutes % 60).toString().padLeft(2, '0')}:'
            '${(el.inSeconds % 60).toString().padLeft(2, '0')}';
      });
    });
    _stopwatch.start();
  }

  void _stop() {
    _timer.cancel();
    _stopwatch.stop();
  }

  void _reset() {
    _stop();
    _stopwatch.reset();
    setState(() { _display = '00:00:00'; });
  }



  List<LiveScore> _listOfScore = [];
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> _getLiveScoreData() async {
    _listOfScore.clear();
    final QuerySnapshot<Map<String, dynamic>> snapshots = await db
        .collection('football')
        .where('id', isEqualTo: widget.docid)
        .get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshots.docs) {
      LiveScore liveScore = LiveScore(
        id: doc.id,
        team1Name: doc.get('team1_name'),
        team2Name: doc.get('team2_name'),
        team1Score: doc.get('team1_score'),
        team2Score: doc.get('team2_score'),
        isRunning: doc.get('is_running'),
        winnerTeam: doc.get('winner_team'),
        stime: doc.get('stime'),
        duration: doc.get('duration'),
      );
      _listOfScore.add(liveScore);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getLiveScoreData();
    _start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.docid,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold, color: Colors.white)),
      backgroundColor: Colors.lightBlueAccent,
      ),
      body: StreamBuilder(
        stream: db.collection('football').snapshots(),
        builder:
            (
            context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshots,
            ) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshots.hasError) {
            return Center(child: Text(snapshots.error.toString()));
          }

          if (snapshots.hasData) {
            _listOfScore.clear();
            for (QueryDocumentSnapshot<Map<String, dynamic>> doc
            in snapshots.data!.docs) {
              LiveScore liveScore = LiveScore(
                id: doc.id,
                team1Name: doc.get('team1_name'),
                team2Name: doc.get('team2_name'),
                team1Score: doc.get('team1_score'),
                team2Score: doc.get('team2_score'),
                isRunning: doc.get('is_running'),
                winnerTeam: doc.get('winner_team'),
                stime: doc.get('stime'),
                duration: doc.get('duration'),
              );
              if (doc.id == widget.docid) {
                _listOfScore.add(liveScore);
              }
            }
          }

          return ListView.builder(
            itemCount: _listOfScore.length,
            itemBuilder: (context, index) {
              LiveScore liveScore = _listOfScore[index];

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 5,
                  child: ListTile(
                    subtitle: Column(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(liveScore.team1Name, style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold, color: Colors.black45),),
                            Text('  vs  ',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold, color: Colors.black45)),
                            Text(liveScore.team2Name,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold, color: Colors.black45)),
                          ],

                        ),
                        Text('${liveScore.stime}',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, color: Colors.black)),
                        Text('Time : $_display', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold, color: Colors.black87)),

                        Text('Total Time: ${liveScore.duration.toString()}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold, color: Colors.black87)),


                      ],
                    ),

                  ),
                ),
              );
            },
          );
        },
      ),

    );
  }
}


class LiveScore {
  final String id;
  final String team1Name;
  final String team2Name;
  final int team1Score;
  final int team2Score;
  final bool isRunning;
  final String winnerTeam;
  final String stime;
  final int duration;


  LiveScore({
    required this.id,
    required this.team1Name,
    required this.team2Name,
    required this.team1Score,
    required this.team2Score,
    required this.isRunning,
    required this.winnerTeam,
    required this.stime,
    required this.duration,
  });

  Map<String, dynamic> toMap() {
    return {
      'team1_name' : team1Name,
      'team2_name' : team2Name,
      'team1_score' : team1Score,
      'team2_score' : team2Score,
      'is_running' : isRunning,
      'winner_team' : winnerTeam,
      'stime' : stime,
      'duration' : duration,
    };
  }
}

