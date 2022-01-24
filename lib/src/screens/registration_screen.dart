import 'package:flutter/material.dart';
import 'package:pacmanchat/src/services/authentication.dart';
import 'package:pacmanchat/src/widgets/app_button.dart';
import 'package:pacmanchat/src/widgets/app_icon.dart';
import 'package:pacmanchat/src/widgets/app_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  _RegistrationScreenState createState() => _RegistrationScreenState();

  static const String routeName = "/registration";
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final auth = FirebaseAuth.instance;

  late String _email;
  late String _password;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late FocusNode _focusNode;

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AppIcon(),
            const SizedBox(
              height: 48.0,
            ),
            AppTextField(
              focusNode: _focusNode,
              controller: emailController,
              inputText: 'Correo electrónico',
              obscureText: false,
              onChanged: (value) {
                _email = value;
              },
            ),
            const SizedBox(height: 8.0),
            AppTextField(
              focusNode:,
              controller: passwordController,
              inputText: 'Contraseña',
              obscureText: true,
              onChanged: (value) {
                _password = value;
              },
            ),
            const SizedBox(height: 23.0),
            AppButton(
                name: 'Registrarse',
                color: Colors.amberAccent,
                onPress: () async {
                  var newUser = await Authentication()
                      .createUser(email: _email, password: _password);
                  if (newUser != null) {
                    Navigator.pushNamed(context, "/chatScreen");
                  }
                  FocusScope.of(context).requestFocus(_focusNode);
                  //Elimina el texto en el textfield una vez presionado "iniciar sesión"
                  emailController.text = "";
                  passwordController.text = "";
                })
          ],
        ),
      ),
    );
  }
}
