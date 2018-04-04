import 'dart:async';
import 'model/user_state.dart';

abstract class DatabaseHelper {
  Future<void> saveUserState(UserState userState);
  Future<int> deleteUserState(UserState userState);
  Future<List<Map<String,String>>> retrieveUserState();
}
