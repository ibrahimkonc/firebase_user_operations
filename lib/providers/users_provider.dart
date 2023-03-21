import 'package:firebase_user_operations/services/services.dart';
import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';

class UsersProvider with ChangeNotifier {
  List<UserModel> userList = [];
  UserModel user = UserModel(name: "", age: 0, email: "", image: "");
  String userID = "";
  Services service = Services();
  bool isAdd = true;
  int countUser = 0;
  bool isHideContainer = false;

  final TextEditingController userName = TextEditingController();
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userAge = TextEditingController();
  final TextEditingController userImage = TextEditingController();

  void isHideContainerOptions() {
    isHideContainer = !isHideContainer;
  }

  void getUserProvider() async {
    userImage.text = "https://picsum.photos/200/300";
    userList = await service.getUsers();
    countUser = userList.length;
    notifyListeners();
  }

  void deleteUserProvider(String id) async {
    await service.deleteUser(id);
    getUserProvider();
    notifyListeners();
  }

  Future<bool> addUserProvider() async {
    if (!(userName.text.isEmpty ||
        userEmail.text.isEmpty ||
        userAge.text.isEmpty ||
        userImage.text.isEmpty)) {
      user.name = userName.text.toString();
      user.email = userEmail.text.toString();
      user.age = int.parse(userAge.text.toString());
      user.image = userImage.text.toString();

      var resposne = await service.postUser(user);

      notifyListeners();
      return resposne == null ? false : true;
    }
    notifyListeners();
    return false;
  }

  void updateUserCompletionsProvider(String id) async {
    var resposne = await service.getUserById(id);
    if (resposne != null) {
      userName.text = resposne.name;
      userEmail.text = resposne.email;
      userAge.text = resposne.age.toString();
      userImage.text = resposne.image;
      userID = resposne.id.toString();
    }
    notifyListeners();
  }

  Future<bool> updateUserProvider() async {
    if (!(userName.text.isEmpty ||
        userEmail.text.isEmpty ||
        userAge.text.isEmpty ||
        userImage.text.isEmpty ||
        userID.isEmpty)) {
      user.name = userName.text.toString();
      user.email = userEmail.text.toString();
      user.age = int.parse(userAge.text.toString());
      user.image = userImage.text.toString();
      user.id = userID;

      var resposne = await service.updateUser(user);

      notifyListeners();
      return resposne == null ? false : true;
    }
    notifyListeners();
    return false;
  }

  void clearInput(BuildContext context) {
    FocusScope.of(context).unfocus();
    user.name = "";
    user.email = "";
    user.age = 0;
    user.image = "";
    userName.text = "";
    userEmail.text = "";
    userAge.text = "";
    userImage.text = "";
    userID = "";
    notifyListeners();
  }
}
