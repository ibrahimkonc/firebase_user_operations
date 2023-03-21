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
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
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
                  _textfield(userProvider.userName, "Kullanıcı Adı Soyadı",
                      Icons.person_add_alt, TextInputType.text),
                  _textfield(userProvider.userEmail, "Email",
                      Icons.mail_outline, TextInputType.text),
                  _textfield(userProvider.userAge, "Yaşınız",
                      Icons.align_vertical_bottom_sharp, TextInputType.number),
                  _textfield(
                      userProvider.userImage,
                      "Resim http://www.image.com",
                      Icons.image_outlined,
                      TextInputType.text),
                  userProvider.userID.isEmpty
                      ? _button(() async {
                          bool response = await userProvider.addUserProvider();
                          if (response) {
                            userProvider.clearInput(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Row(
                                children: const [
                                  Icon(Icons.check, color: Colors.white),
                                  Text(' Kullanıcı Eklendi')
                                ],
                              ),
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Row(
                                children: const [
                                  Icon(Icons.disabled_by_default_outlined,
                                      color: Colors.white),
                                  Text(' Lütfen Boş Bırakmayınız / Hata !'),
                                ],
                              ),
                            ));
                          }
                        }, "Kullanıcı Ekle", context, Icons.add_box_outlined,
                          const Color(0xFF2F2C7F))
                      : _button(() async {
                          bool response =
                              await userProvider.updateUserProvider();
                          if (response) {
                            userProvider.clearInput(context);

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Row(
                                children: const [
                                  Icon(Icons.update_outlined,
                                      color: Colors.white),
                                  Text(' Kullanıcı Güncellendi'),
                                ],
                              ),
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Row(
                                children: const [
                                  Icon(Icons.disabled_by_default_outlined,
                                      color: Colors.white),
                                  Text(' Lütfen Boş Bırakmayınız / Hata !'),
                                ],
                              ),
                            ));
                          }
                        }, "Kullanıcı Güncelle", context,
                          Icons.file_upload_outlined, Colors.blueAccent),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 6), // changes position of shadow
                  ),
                ],
              ),
              child: const Divider(
                height: 0,
                indent: 15,
                endIndent: 15,
                thickness: 0,
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: userProvider.userList.isEmpty
                  ? const Text("Kayıt Bulunamamıştır")
                  : ListView(
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

  Widget _textfield(TextEditingController controller, String label,
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
