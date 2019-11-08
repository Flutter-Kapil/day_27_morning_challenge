import 'dart:convert';
import 'package:http/http.dart';

class PlayerDetail{
  String url = 'https://www.balldontlie.io/api/v1/players/';
  int playerNo;

  PlayerDetail(this.playerNo);


  Future<int> fetchPlayerWeight() async {
//    print('$url$playerNo');
    Response response = await get('$url$playerNo');
    Map<String, dynamic> playerDetailsMap = jsonDecode(response.body);
//    print(playerDetailsMap['weight_pounds']);
    return playerDetailsMap['weight_pounds'];
  }
}