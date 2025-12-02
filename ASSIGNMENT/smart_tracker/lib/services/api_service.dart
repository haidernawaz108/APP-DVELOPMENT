import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // 👇 Yahan apna real backend URL lagana hai
  final String baseUrl = "https://your-api-url.com/activities";

  // GET Activities
  Future<List<dynamic>> getActivities() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  // POST Activity (Save)
  Future<bool> addActivity(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  // DELETE Activity
  Future<bool> deleteActivity(String id) async {
    try {
      final response = await http.delete(Uri.parse("$baseUrl/$id"));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
