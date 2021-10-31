import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:last_test/models/lanuage_model.dart';
import 'package:last_test/utils/response.dart';

const String fullUrl = 'https://google-translate1.p.rapidapi.com/language/translate/v2/languages';
Future<Response> getLanguageFromApi() async {
  String url = fullUrl;
  http.Response response = await http.get(
    Uri.parse(url),
    headers: {
      'content-type': 'application/json',
      'accept': 'application/json',
      'accept-encoding': 'application/gzip',
      'x-rapidapi-host': 'google-translate1.p.rapidapi.com',
      'x-rapidapi-key': 'f933a24ef2msh9b7c560a28f9fdfp1ee58bjsn9bebc072c44a',
    },
  );
  var data = json.decode(response.body)['data']['languages'];
  //print("decode");
  //print(data);
  if (response.statusCode == 200) {
    //print("success");
    List list = (data as List).map((e) => Language.fromJson(e)).toList();
    //print("yes");
    //print(list.length);
    return Response(200, list);
  }else if (response.statusCode == 401 || response.statusCode == 403) {
    return Response(401, null);
  } else if (response.statusCode == 500) {
    return Response(500, "Internal server error");
  } else {
    return Response(-1, "Exception");
  }
}
Future<Response> postToServer(String t , String q) async {
  String fullUrl = 'https://google-translate1.p.rapidapi.com/language/translate/v2';
  //print ("$target");
  //print(q);
  var body = {
    "source": 'ar',
    "target": t,
    "q": q,
  };
  //print(body);
  http.Response response = await http.post(
      Uri.parse(fullUrl),
      headers: {
        //'content-type': 'application/json',
        'accept': 'application/json',
        'accept-encoding': 'application/gzip',
        'x-rapidapi-host': 'google-translate1.p.rapidapi.com',
        'x-rapidapi-key': 'f933a24ef2msh9b7c560a28f9fdfp1ee58bjsn9bebc072c44a',
      },
      body: body,
  );
  var data = json.decode(response.body);
  //print("succes");
  //print(response.statusCode);
  print (response.body.toString());
  if (response.statusCode == 200) {
    return Response(200, "post request send Successfully");
  } else if (response.statusCode == 401 || response.statusCode == 403) {
    return Response(401, null);
  } else if (response.statusCode == 500) {
    return Response(500, "Internal server error");
  } else {
    return Response(-1, "Exception");
  }
}