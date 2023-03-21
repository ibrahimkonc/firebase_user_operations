import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel userList;

  const UserCard({super.key, required this.userList});
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Image.network(
                    userList.image.toString(),
                    width: 50,
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
    );
  }
}
