import 'package:firebase_user_operations/components/user_cart.dart';
import 'package:firebase_user_operations/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UsersProvider>(context);
    userProvider.getUserProvider();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF2F2C7F),
        title: const Text("Kullanıcı Listesi"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(33.0),
        child: Column(
          children: [
            // Row(children: [
            //   // Expanded(
            //   //   child: TextField(
            //   //     controller: data,
            //   //     decoration: const InputDecoration(
            //   //       prefixIcon: Align(
            //   //         widthFactor: 1.0,
            //   //         heightFactor: 1.0,
            //   //         child: Icon(Icons.person_add_alt),
            //   //       ),
            //   //       border: OutlineInputBorder(),
            //   //       hintText: 'Kullanıcı Adı Soyadı',
            //   //     ),
            //   //   ),
            //   // ),
            //   IconButton(
            //     onPressed: () {
            //       if (!data.text.toString().isEmpty) {
            //         kullanicilar.add(data.text.toString());
            //         setState(() {});
            //       } else {
            //         print("Lütfen Boş Bırakmayınız !");
            //       }
            //     },
            //     icon: const Icon(Icons.add_box_outlined),
            //     color: const Color(0xFF2F2C7F),
            //     iconSize: 45.0,
            //   )
            // ]),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: userProvider.userList
                    .map((e) => UserCard(userList: e))
                    .toList()
                    .reversed
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
