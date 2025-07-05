import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl = "https://roadmapai-7it5.onrender.com/api";

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("$_baseUrl/auth/login");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return data;
      } else {
        return data;
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Something went wrong: $e',
      };
    }
  }

  Future<Map<String, dynamic>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("$_baseUrl/auth/signup");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {'status': response.statusCode, 'message': data['message']};
      } else {
        return {'status': response.statusCode, 'message': data['message']};
      }
    } catch (e) {
      return {'status': 404, 'message': 'Something went wrong: $e'};
    }
  }

  Future<Map<String, dynamic>> createRoadmap(
      {required String goal, required int weeks, required String token}) async {
    try {
      final url = Uri.parse("$_baseUrl/roadmap/ai");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode({
          "goal": goal,
          "weeks": weeks,
        }),
      );
      final data = jsonDecode(response.body);
      return data;
    } catch (e) {
      return {'status': 'error', 'message': 'Something went wrong: $e'};
    }
  }

  Future<int> saveRoadmap(
      {required int id,
      required String token,
      required Map<String, dynamic> roadmap}) async {
    final url = Uri.parse("$_baseUrl/roadmap/save/$id");
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(roadmap),
      );
      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        print(response.body);
        return response.statusCode;
      }
    } catch (e) {
      print(e.toString());
      return 404;
    }
  }

  Future<List<dynamic>> fetchLearningPath({
    required int userId,
    required String token,
  }) async {
    final url = Uri.parse(
      '$_baseUrl/learning-path/$userId',
    );
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        print(response.body);
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<Map<String, dynamic>> getRoadmap(
      {required int userId,
      required int learningPathId,
      required String token}) async {
    try {
      final url = Uri.parse(
          "$_baseUrl/roadmap?userId=$userId&learningPathId=$learningPathId");

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      final data = jsonDecode(response.body);
      return data;
    } catch (e) {
      return {'status': 'error', 'message': 'Something went wrong: $e'};
    }
  }

  Future<int> markTopicCompleted({
    required int userId,
    required int topicId,
    required String token,
  }) async {
    final url = Uri.parse("$_baseUrl/progress/markCompleted");
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode({
          "userId": userId,
          "topicId": topicId,
        }),
      );
      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        return response.statusCode;
      }
    } catch (e) {
      log(e.toString());
      return 404;
    }
  }

  Future<int> unmarkTopic({
    required int userId,
    required int topicId,
    required String token,
  }) async {
    final url = Uri.parse("$_baseUrl/progress/unmarkCompleted");
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode({
          "userId": userId,
          "topicId": topicId,
        }),
      );
      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        return response.statusCode;
      }
    } catch (e) {
      log(e.toString());
      return 404;
    }
  }

  Future<int> getTotalRoadmaps({required String token}) async {
    try {
      final url = Uri.parse("$_baseUrl/learning-path/count");

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      final data = jsonDecode(response.body);
      return data['data']['count'];
    } catch (e) {
      log(e.toString());
      return -1;
    }
  }

  Future<int> getUsersCount({required String token}) async {
    try {
      final url = Uri.parse("$_baseUrl/auth/users/count");

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      final data = jsonDecode(response.body);
      return data['data']['count'];
    } catch (e) {
      log(e.toString());
      return -1;
    }
  }

  Future<Map<String, dynamic>> deleteLearningPath(
      {required int learningPathId, required String token}) async {
    try {
      final url = Uri.parse("$_baseUrl/learning-path/delete/$learningPathId");

      final response = await http.delete(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      final data = jsonDecode(response.body);
      return data;
    } catch (e) {
      log(e.toString());
      return {'status': 'error', 'message': 'Something went wrong.'};
    }
  }
}
