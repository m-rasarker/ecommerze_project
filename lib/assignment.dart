import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_project/assignment_page2.dart';
import 'package:flutter/material.dart';


class Assignment extends StatefulWidget {
  const Assignment({super.key});

  @override
  State<Assignment> createState() => _AssignmentState();
}

class _AssignmentState extends State<Assignment> {
  List<LiveScore> _listOfScore = [];
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> _getLiveScoreData() async {
    _listOfScore.clear();
    final QuerySnapshot<Map<String, dynamic>> snapshots = await db
        .collection('football')
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Match List',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold, color: Colors.white)),
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
              _listOfScore.add(liveScore);
            }
          }

          return ListView.builder(
            itemCount: _listOfScore.length,
            itemBuilder: (context, index) {
              LiveScore liveScore = _listOfScore[index];

              return ListTile(
                // onLongPress: () {
                //   db.collection('football').doc(liveScore.id).delete();
                // },


                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(liveScore.team1Name,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold, color: Colors.black54)),
                        Text('  vs  ',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold, color: Colors.black54)),
                        Text(liveScore.team2Name,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold, color: Colors.black54)),
                      ],
                    ),

                  ],
                ),
                  trailing: InkWell(
                      onTap: (){

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AssignmentPage2(docid: liveScore.id),
                          ),
                        );
                      },

                      child: Icon(Icons.arrow_forward, color: Colors.black54,)) ,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          LiveScore liveScore = LiveScore(
              id: 'ItalyvsSpain',
              team1Name: 'Italy',
              team2Name: 'Spain',
              team1Score: 1,
              team2Score: 2,
              isRunning: true,
              winnerTeam: 'Spain',
              stime: '3:00',
              duration: 90

          );

          await db.collection('football')
              .doc(liveScore.id)
              .set(liveScore.toMap());
        },
        child: Icon(Icons.add),
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

