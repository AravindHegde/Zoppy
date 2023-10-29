import 'package:shared_preferences/shared_preferences.dart';
class SecureStorage{
  late SharedPreferences _preferences ;
  late String _token ;
  static final SecureStorage _instance = SecureStorage._();
  SecureStorage._();

  factory SecureStorage(){
    return _instance;
  }
  Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
    _token = 'auth_token';
  }

  void setToken(String value){
     _preferences.setString(_token, value);
  }

  String? getToken() {
    return _preferences.getString(_token);
  }
  bool containsToken(){
    return _preferences.containsKey(_token);
  }
  Future<void> clear() async {
    await _preferences.clear();
  }


}