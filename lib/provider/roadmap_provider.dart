import 'package:flutter/material.dart';
import 'package:path_finder/api/auth_service.dart';
import 'package:path_finder/util/shared_pref_helper.dart';

class RoadmapProvider with ChangeNotifier {
  Map<String, dynamic> _roadmap = {};
  final AuthService _service = AuthService();
  final Set<int> _loadingTopicIds = {};

  bool _isLoading = false; // <-- Add this line
  int _learningPathId = -1; // <-- store it here

  Map<String, dynamic> get roadmap => _roadmap;
  bool get isLoading => _isLoading; // <-- And this getter
  int get learningPathId => _learningPathId;

  bool isTopicLoading(int topicId) {
    return _loadingTopicIds.contains(topicId);
  }

  // Setter
  void setLearningPathId(int id) {
    _learningPathId = id;
    notifyListeners(); // optional: only if you want UI to respond to this
  }

  Future<void> fetchRoadmap(int learningPathId) async {
    _isLoading = true;
    notifyListeners();

    // Set learningPathId here
    _learningPathId = learningPathId;

    final token = await SharedPrefHelper.getToken();
    final userId = await SharedPrefHelper.getId();
    final data = await _service.getRoadmap(
      userId: userId,
      learningPathId: learningPathId,
      token: token,
    );

    _roadmap = data;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleTopicCompletion(Map<String, dynamic> topic) async {
    final topicId = topic['id'];
    _loadingTopicIds.add(topicId);
    notifyListeners();

    final token = await SharedPrefHelper.getToken();
    final userId = await SharedPrefHelper.getId();
    final bool isCompleted = topic['isCompleted'] ?? false;

    int result;
    if (isCompleted) {
      result = await _service.unmarkTopic(
        userId: userId,
        topicId: topicId,
        token: token,
      );
    } else {
      result = await _service.markTopicCompleted(
        userId: userId,
        topicId: topicId,
        token: token,
      );
    }

    if (result == 200) {
      topic['isCompleted'] = !isCompleted;
      await fetchRoadmap(_learningPathId);
    }

    _loadingTopicIds.remove(topicId);
    notifyListeners();
  }
}
