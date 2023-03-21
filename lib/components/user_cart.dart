import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../providers/users_provider.dart';

class UserCard extends StatelessWidget {
  final UserModel userList;

  const UserCard({super.key, required this.userList});
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UsersProvider>(context);

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(10.0),
          color: const Color(0xFF2F2C7F),
          child: Container(
            height: 120.0,
            color: Colors.white,
            margin: const EdgeInsets.fromLTRB(1.0, 20.0, 1.0, 1.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image(
                          width: 45,
                          image: NetworkImage(userList.image.toString()),
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Kullanıcı Adı: ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                userList.name.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "Email: ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                userList.email.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "Yaşı: ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                userList.age.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
            child: const Icon(Icons.update),
            onPressed: () {
              userProvider
                  .updateUserCompletionsProvider(userList.id.toString());
            },
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Icon(Icons.delete),
            onPressed: () {
              userProvider.deleteUserProvider(userList.id.toString());
            },
          ),
        ),
      ],
    );
  }
}
