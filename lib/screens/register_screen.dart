import 'package:flutter/material.dart';
import 'package:flutter_formulario/providers/login_form_probider.dart';
import 'package:flutter_formulario/router/app_router.dart';
import 'package:flutter_formulario/services/services.dart';
import 'package:flutter_formulario/ui/input_decorations.dart';
import 'package:flutter_formulario/widgets/widgests.dart';
import 'package:provider/provider.dart';

class RegsiterScreen extends StatelessWidget {
  const RegsiterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 250,
            ),
            CardContainer(
              child: Column(children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Crear Cuenta',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  height: 30,
                ),
                ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(),
                  child: _LoginForm(),
                )
              ]),
            ),
            SizedBox(
              height: 50,
            ),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(
                  context, AppRoute.loginScreenRoute),
              child: Text(
                'Ya tienes una cuenta?',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.indigo),
              ),
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.indigo)),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      )),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
          //TODO mantener referencia
          key: loginForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hindText: 'carlos@mail.com',
                    labelText: 'Correo Eletronico',
                    prefixIcon: Icons.alternate_email),
                onChanged: (value) => loginForm.email = value,
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                  RegExp regExp = RegExp(pattern);
                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'Correo Invalido';
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hindText: '********',
                    labelText: 'Contrasena',
                    prefixIcon: Icons.lock),
                onChanged: (value) => loginForm.password = value,
                validator: (value) {
                  if (value != null && value.length >= 6) return null;
                  return 'Contrasena Invalida';
                },
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        final authService = Provider.of<AuthService>(context,
                            listen: false); //Quitar teclado

                        final String? errorMessage = await authService
                            .createUser(loginForm.email, loginForm.password);

                        if (errorMessage == null) {
                          Navigator.pushReplacementNamed(
                              context, AppRoute.homeScreenRoute);
                        } else {
                          NotificationsService.showSnackBar(errorMessage);
                          loginForm.isLoading = false;
                        }
                      },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                disabledColor: Colors.grey,
                color: Colors.deepPurple,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text(
                    loginForm.isLoading ? 'Espere' : 'Ingresar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
