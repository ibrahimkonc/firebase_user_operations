import 'package:firebase_user_operations/components/user_cart.dart';
import 'package:firebase_user_operations/providers/users_provider.dart';
import 'package:firebase_user_operations/screens/login.dart';
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
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.exit_to_app_rounded),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        // ignore: prefer_interpolation_to_compose_strings
        title: Text("Kullanıcı Listesi [ " +
            userProvider.countUser.toString() +
            " Adet]"),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue,
            Colors.red,
          ],
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 10),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  userProvider.isHideContainerOptions();
                },
                child: const Text(
                  "Kullanıcı Ekle",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 250),
                decoration: userProvider.isHideContainer
                    ? BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 255, 255, 255)
                                .withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      )
                    : null,
                padding: const EdgeInsets.all(15),
                height: userProvider.isHideContainer ? 350 : 0,
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
                    _textfield(
                        userProvider.userAge,
                        "Yaşınız",
                        Icons.align_vertical_bottom_sharp,
                        TextInputType.number),
                    _textfield(
                        userProvider.userImage,
                        "Resim http://www.image.com",
                        Icons.image_outlined,
                        TextInputType.text),
                    userProvider.userID.isEmpty
                        ? _button(() async {
                            bool response =
                                await userProvider.addUserProvider();
                            if (response) {
                              userProvider.clearInput(context);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Row(
                                  children: const [
                                    Icon(Icons.check, color: Colors.white),
                                    Text(' Kullanıcı Eklendi')
                                  ],
                                ),
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
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
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Row(
                                  children: const [
                                    Icon(Icons.update_outlined,
                                        color: Colors.white),
                                    Text(' Kullanıcı Güncellendi'),
                                  ],
                                ),
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
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
              // Container(
              //   margin: const EdgeInsets.symmetric(vertical: 15),
              //   decoration: BoxDecoration(
              //     boxShadow: [
              //       BoxShadow(
              //         color:
              //             Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
              //         spreadRadius: 2,
              //         blurRadius: 9,
              //         offset: const Offset(0, 6), // changes position of shadow
              //       ),
              //     ],
              //   ),
              //   child: const Divider(
              //     height: 0,
              //     indent: 15,
              //     endIndent: 15,
              //     thickness: 0,
              //     color: Colors.grey,
              //   ),
              // ),
              Expanded(
                child: userProvider.userList.isEmpty
                    ? Container(
                        margin: EdgeInsets.symmetric(vertical: 30),
                        child: const Text(
                          "Kayıt Bulunamamıştır",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      )
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
