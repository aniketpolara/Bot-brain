import 'dart:convert';
import 'dart:developer';

import 'package:bot_brain/constant/constant.dart';
import 'package:bot_brain/model/image_mode.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static var client = http.Client();

  static Future<String> chatCompeletionResponse(String prompt) async {
    var url = Uri.https("api.openai.com", "/v1/chat/completions");
    log("prompt : $prompt");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Constant.apiKey}',
      },
      body: json.encode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "user", "content": prompt}
        ]
      }),
    );
    Map<String, dynamic> newresponse = jsonDecode(utf8.decode(response.bodyBytes));

    log(newresponse['choices'][0]['message']['content']);
    return newresponse['choices'][0]['message']['content'];
  }

  static Future<List<ImageData>?> imageGenerateResponse(String prompt, String size) async {
    var url = Uri.https("api.openai.com", "/v1/images/generations");
    log("prompt : $prompt");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Constant.apiKey}',
      },
      body: json.encode({"prompt": prompt, "n": 10, "size": size}),
    );

    Map<String, dynamic> responseBody = json.decode(response.body);

    ImageModel imageModel = ImageModel.fromJson(responseBody);
    if (imageModel.data != null && imageModel.data!.isNotEmpty) {
      return imageModel.data;
    }
    return null;
  }
}
