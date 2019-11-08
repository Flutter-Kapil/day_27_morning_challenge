import 'dart:math';
import 'package:executor/executor.dart';

import 'network_helper.dart';

// Challenge 1
// Flutter module makes multiple, parallel, requests to a web service, and
// shares the result with the host app. We'll use the "balldontlie" API for this
// purpose, since it's open and supports cross-domain requests for web apps. in
// this case, the input value represents the number of calls to be made, eg a
// value of 3 means we will fetch data for players 1, 2, 3. The URL for player 2,
// for example, is:
// https://www.balldontlie.io/api/v1/players/1
// Once all calls have been made, the Flutter module should calculate average
// weight of all queried players and print it in console.
//  The calls must occur in parallel, always using up to *four* separate threads,
// in a typical "worker" pattern, to ensure there are always three pending requests
// until no further requests are needed. The requests should be logged when initiated
// and again when completed.

// Challenge 2
// A point on the screen (pt1) wants to move a certain distance (dist) closer to
// another point on the screen (pt2) The function has three arguments,
// two of which are objects with x & y values, and the third being the distance,
// e.g. {x:50, y:60}, {x: 100, y: 100}, 10. The expected result is a similar
// object with the new co-ordinate.
  movePoint(Map pt1, Map pt2, int distanceToMove){
  //calculate distance between these two points first
    //d(P;Q)=p(x2−x1)2+(y2−y1)2
    double totalDistance = sqrt((pt2['x']*pt2['x']-pt1['x']*pt1['x'])+(pt2['y']*pt2['y']-pt1['y']*pt1['y']));
    double m1 = distanceToMove.toDouble();
    double m2 = totalDistance-distanceToMove;

    double xCord = ((m1*pt2['x'])+(m2*pt1['x']))/(m1+m2);
    double yCord =  ((m1*pt2['y'])+(m2*pt1['y']))/(m1+m2);
     return {'x':xCord.toInt(), 'y':yCord.toInt()};
  }
  
  
  avgWeight(int n){
    List playersWeight=[];
    Executor executor = Executor(concurrency: 3);
    for (int i = 0; i < n; i++) {
      executor.scheduleTask(() async {
        int currentPlayerWeight = await PlayerDetail(i+1).fetchPlayerWeight();
        print('courrentPlayerNo: ${i+1} currentPlayerWeight : $currentPlayerWeight ');

        if(currentPlayerWeight!=null){
          playersWeight.add(currentPlayerWeight);
        }

      });
      print(playersWeight);
      print('i+1 is ${i+1}');
    }
  }

Future main() async{

//    print(movePoint({'x':50, 'y':60}, {'x': 100, 'y': 100},10));
//    print(movePoint({'x':0, 'y':0}, {'x': 0, 'y': 10},5));
    
  avgWeight(4);
}
