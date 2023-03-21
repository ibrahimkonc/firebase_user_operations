import 'package:firebase_user_operations/services/services.dart';
import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';

class UsersProvider with ChangeNotifier {
  List<UserModel> userList = [];

  Services service = Services();

  void getUserProvider() async {
    userList = await service.getUsers();
    notifyListeners();
  }
}
