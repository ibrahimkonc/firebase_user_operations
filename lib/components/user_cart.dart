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
        FittedBox(
          child: Container(
            decoration: _boxDecoration,
            margin: const EdgeInsets.all(10.0),
            //color: const Color(0xFF2F2C7F),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.135,
              margin: const EdgeInsets.fromLTRB(1.0, 15.0, 1.0, 1.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Material(
                            shape: const CircleBorder(side: BorderSide.none),
                            elevation: 15,
                            child: CircleAvatar(
                              backgroundImage: userList.image.isEmpty
                                  ? null
                                  : NetworkImage(userList.image.toString()),
                              radius: 32,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 18),
                          color: Color.fromARGB(42, 158, 158, 158),
                          width: 2,
                          height: 85,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Kullanıcı Adı: ",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    userList.name.toString(),
                                    style: const TextStyle(fontSize: 15.0),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Email: ",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    userList.email.toString(),
                                    style: const TextStyle(fontSize: 15.0),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Yaşı: ",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    userList.age.toString(),
                                    style: const TextStyle(fontSize: 15.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              elevation: 8,
              shadowColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
            ),
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
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              elevation: 8,
              shadowColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
            ),
            child: const Icon(Icons.delete),
            onPressed: () {
              showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Row(
                        children: const [
                          Icon(Icons.error_outline),
                          Text(' Onay Mesajı'),
                        ],
                      ),
                      content: const Text('Kullanıcı Silinsin mi ?'),
                      actions: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text('Evet'),
                          onPressed: () {
                            userProvider
                                .deleteUserProvider(userList.id.toString());
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text('Hayır'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            },
          ),
        ),
      ],
    );
  }

  BoxDecoration get _boxDecoration {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10)),
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    );
  }
}
