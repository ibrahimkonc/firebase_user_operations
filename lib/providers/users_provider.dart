import 'package:firebase_user_operations/services/services.dart';
import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';

class UsersProvider with ChangeNotifier {
  List<UserModel> userList = [];
  Services service = Services();
  UserModel user = UserModel(name: "", age: 0, email: "", image: "");

  final TextEditingController userName = TextEditingController();
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userAge = TextEditingController();
  final TextEditingController userImage = TextEditingController();

  void getUserProvider() async {
    userList = await service.getUsers();
    notifyListeners();
  }

  void deleteUserProvider(String id) async {
    await service.deleteUser(id);
    getUserProvider();
    notifyListeners();
  }

  void addUserProvider() async {
    user.name = userName.text.toString();
    user.email = userEmail.text.toString();
    user.age = int.parse(userAge.text.toString());
    user.image = userImage.text.toString();

    var resposne = await service.postUser(user);
    print(resposne);
    notifyListeners();
  }
}
