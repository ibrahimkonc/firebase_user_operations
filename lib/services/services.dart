import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

// class ApiConfig {
//   static ApiConfig shared = ApiConfig();
//   String token = "";
// }

const String _baseUrl =
    "https://fir-user-operations-e2566-default-rtdb.firebaseio.com/";

class Services {
  Uri getUrl(String endpoint) => Uri.parse("$_baseUrl/$endpoint.json");

  Future<List<UserModel>> getUsers() async {
    //ApiConfig.shared.token = "asdjdashjsbfajkbh";
    http.Response response = await http.get(getUrl("users"));
    List<UserModel> list = [];
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var data = json.decode(response.body);
      for (var key in data.keys) {
        UserModel user = UserModel.fromMap(data[key]);
        user.id = key;
        list.add(user);
      }
    }
    return list;
  }

  Future<UserModel?> getUserById(String id) async {
    http.Response response = await http.get(getUrl("users/$id"));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return UserModel.fromJson(response.body)..id = id;
    } else {
      return null;
    }
  }

  Future<UserModel?> postUser(UserModel user) async {
    http.Response response = await http.post(getUrl("users"),
        body: user.toJson(), headers: {"Content-Type": "application/json"});
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var data = json.decode(response.body);
      user.id = data["name"];
      return user;
    } else {
      return null;
    }
  }

  Future<bool> updateUser(UserModel user) async {
    http.Response response = await http.put(getUrl("users/${user.id}"),
        body: user.toJson(), headers: {"Content-Type": "application/json"});
    return response.statusCode >= 200 && response.statusCode < 300;
  }

  Future<bool> deleteUser(String id) async {
    http.Response response = await http.delete(getUrl("users/$id"));
    return response.statusCode >= 200 && response.statusCode < 300;
  }
}
