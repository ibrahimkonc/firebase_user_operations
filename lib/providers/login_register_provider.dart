import 'package:flutter/cupertino.dart';

class LoginRegisterProvider with ChangeNotifier {
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  TextEditingController get getUsernameController => usernameController;
  TextEditingController get getPasswordController => passwordController;

  void data() {
    notifyListeners();
  }
}
