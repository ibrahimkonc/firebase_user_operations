import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_user_operations/screens/register.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usernameController = TextEditingController(text: "admin@gmail.com");
    passwordController = TextEditingController(text: "123567890");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 40),
            padding: const EdgeInsets.all(10),
            height: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Giriş yap",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                ),
                const SizedBox(height: 20),
                _textfiled(usernameController, "Username"),
                _textfiled(passwordController, "Password"),
                const SizedBox(height: 20),
                _button(() async {
                  FirebaseAuth auth = FirebaseAuth.instance;
                  try {
                    UserCredential credential =
                        await auth.signInWithEmailAndPassword(
                            email: usernameController.text,
                            password: passwordController.text);
                    print(credential);
                  } catch (e) {
                    print(e.toString());
                  }
                }, "Login"),
                _button(() {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const RegisterPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(0.0, 1.0);
                          const end = Offset.zero;
                          final tween = Tween(begin: begin, end: end);
                          final offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ));
                }, "Register")
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textfiled(TextEditingController controller, String label) =>
      TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
      );

  Widget _button(Function() onPressed, String text) {
    return ElevatedButton(onPressed: onPressed, child: Text(text));
  }
}
