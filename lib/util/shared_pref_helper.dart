import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static const String _keyName = 'user_name';
  static const String _keyEmail = 'user_email';
  static const String _keyToken = 'user_token';
  static const String _keyId = 'user_id';
  static const String _keyRegistered = 'is_registered';
  static const String _keyThemeMode = 'theme_mode';

  static Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  static Future<void> saveThemeMode(bool isDarkMode) async {
    final prefs = await _prefs;
    await prefs.setBool(_keyThemeMode, isDarkMode);
  }

  /// Save user data
  static Future<void> saveUserData({
    required String name,
    required String email,
    required String token,
    required int id,
    required bool isRegistered,
  }) async {
    final prefs = await _prefs;
    await prefs.setString(_keyName, name);
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyToken, token);
    await prefs.setInt(_keyId, id);
    await prefs.setBool(_keyRegistered, isRegistered);
  }

  static Future<bool> getThemeMode() async {
    final prefs = await _prefs;
    return prefs.getBool(_keyThemeMode) ??
        false; // false = light mode by default
  }

  static Future<String> getName() async =>
      (await _prefs).getString(_keyName) ?? '';

  static Future<String> getEmail() async =>
      (await _prefs).getString(_keyEmail) ?? '';

  static Future<String> getToken() async =>
      (await _prefs).getString(_keyToken) ?? '';

  static Future<int> getId() async => (await _prefs).getInt(_keyId) ?? -1;

  static Future<bool> getRegistered() async =>
      (await _prefs).getBool(_keyRegistered) ?? false;

  /// Clear all saved data
  static Future<void> clearUserData() async {
    final prefs = await _prefs;
    await prefs.remove(_keyName);
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyToken);
    await prefs.remove(_keyId);
    await prefs.remove(_keyRegistered);
  }
}
