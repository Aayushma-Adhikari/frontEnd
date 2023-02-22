// import 'package:http/http.dart' as http;

// const String baseUrl = 'http://127.0.0.1:3789';

// class BaseClient {
//   var client = http.Client();
//   Future<dynamic> get(String api) async {
//     var url = Uri.parse(baseUrl + api);
//     var response = await client.get(url);
//     if (response.statusCode == 200) {
//       return response.body;
//     } else {
//       //throw exception annd catch it in UT
//     }

//     Future<dynamic> get(String api) async {}

//     Future<dynamic> get(String api) async {}

//     Future<dynamic> get(String api) async {}
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

String apiBaseUrl = 'http://127.0.0.1:3789';

Future<String> encodeText(
    String textToEncode, String password, String imagePath) async {
  final response = await http.post(Uri.parse('$apiBaseUrl/encode'), body: {
    'text_to_encode': textToEncode,
    'password': password,
    'image_path': imagePath,
  });
  if (response.statusCode == 200) {
    Map<String, dynamic> responseData = jsonDecode(response.body);
    return responseData['encoded_image'];
  } else {
    throw Exception('Failed to encode text: ${response.reasonPhrase}');
  }
}

Future<String> decodeText(String password, String imagePath) async {
  final response = await http.post(Uri.parse('$apiBaseUrl/decode'), body: {
    'password': password,
    'image_path': imagePath,
  });
  if (response.statusCode == 200) {
    Map<String, dynamic> responseData = jsonDecode(response.body);
    return responseData['decoded_text'];
  } else {
    throw Exception('Failed to decode image: ${response.reasonPhrase}');
  }
}
