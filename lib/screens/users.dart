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
        padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(15),
              height: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Kullanıcı Ekle",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2F2C7F)),
                  ),
                  const SizedBox(height: 20),
                  _textfiled(userProvider.userName, "Kullanıcı Adı Soyadı",
                      Icons.person_add_alt, TextInputType.text),
                  _textfiled(userProvider.userEmail, "Email",
                      Icons.mail_outline, TextInputType.text),
                  _textfiled(userProvider.userAge, "Yaşınız",
                      Icons.align_vertical_bottom_sharp, TextInputType.number),
                  _textfiled(
                      userProvider.userImage,
                      "Resim http://www.image.com",
                      Icons.image_outlined,
                      TextInputType.text),
                  userProvider.userID.isEmpty
                      ? _button(() async {
                          bool response = await userProvider.addUserProvider();
                          if (response) {
                            userProvider.clearInput(context);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Kullanıcı Eklendi'),
                            ));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Lütfen Boş Bırakmayınız / Hata !'),
                            ));
                          }
                        }, "Kullanıcı Ekle", context, Icons.add_box_outlined,
                          const Color(0xFF2F2C7F))
                      : _button(() async {
                          bool response =
                              await userProvider.updateUserProvider();
                          if (response) {
                            userProvider.clearInput(context);

                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Kullanıcı Güncellendi'),
                            ));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Lütfen Boş Bırakmayınız / Hata !'),
                            ));
                          }
                        }, "Kullanıcı Güncelle", context,
                          Icons.file_upload_outlined, Colors.blueAccent),
                ],
              ),
            ),
            const Divider(color: Color(0xFF2F2C7F), height: 30),
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

  Widget _textfiled(TextEditingController controller, String label,
          IconData icon, TextInputType type) =>
      Expanded(
        child: TextField(
          keyboardType: type,
          style:
              const TextStyle(fontSize: 14, height: 2.0, color: Colors.black),
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0.0),
            prefixIcon: Align(
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: Icon(icon),
            ),
            border: const OutlineInputBorder(),
            hintText: label,
          ),
        ),
      );

  Widget _button(Function() onPressed, String text, BuildContext context,
      IconData icon, Color color) {
    return IconButton(
      tooltip: text,
      onPressed: onPressed,
      icon: Icon(icon),
      color: color,
      iconSize: 35.0,
    );
    // ElevatedButton(onPressed: onPressed, child: Text(text));
  }
}
