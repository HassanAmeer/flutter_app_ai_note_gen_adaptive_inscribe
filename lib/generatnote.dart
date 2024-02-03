import 'package:langchain_openai/langchain_openai.dart';
import 'package:langchain/langchain.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GenerateNote {
  void getNewNoteF(noteaccordingtoTemplateVALUE) async {
    final String apiKey = "sk-xaklmkdwouieqwenqidwednewnsdmsdfwekjkwelna";
    final String prompt = "$noteaccordingtoTemplateVALUE.context{}";

    try {
      final pj = OpenAI(apiKey: apiKey);
      final messages = [
        ChatMessage.system(prompt),
      ];

      final sos = await pj.predictMessages(messages);
      // final data =
      //     sos.contentAsString.replaceAll(RegExp(r'^\s*', multiLine: true), '');
      final String generatedText = await generateText(sos.content, apiKey);
      int data1 = generatedText.indexOf(':');
      String data2 = '';
      if (data1 != -1) {
        data2 = generatedText.substring(data1 + 1).trim();
      } else {
        data2 = generatedText;
      }
      print("Generated Text: $data2");
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<String> generateText(String prompt, String apiKey) async {
    final String apiUrl =
        "https://api.openai.com/v1/engines/davinci/completions";
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey",
    };

    final Map<String, dynamic> requestBody = {
      "prompt": prompt,
      "temperature": 0.7,
      "max_tokens": 100,
      "top_p": 1,
      "frequency_penalty": 0,
      "presence_penalty": 0,
    };

    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String generatedText = responseData['choices'][0]['text'];
      return generatedText;
    } else {
      throw Exception(
          'Failed to generate text. Status code: ${response.statusCode}');
    }
  }
}
