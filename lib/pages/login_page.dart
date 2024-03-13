import 'package:flutter/material.dart';
import 'package:qrscanner/routes/app_pages.dart';

import '../bloc/bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cEmail = TextEditingController(text: "admin@email.com");
    var cPass = TextEditingController(text: "akmal123");
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: ListView(
        padding: const EdgeInsets.all(15.0),
        children: [
          TextField(
            autocorrect: false,
            controller: cEmail,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            autocorrect: false,
            controller: cPass,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              context
                  .read<AuthBloc>()
                  .add(AuthEvLogin(email: cEmail.text, pass: cPass.text));
            },
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20.0)),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthStLogin) context.goNamed(Routes.home);
                if (state is AuthStError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.msg.toString())));
                }
              },
              builder: (context, state) {
                if (state is AuthStLoading) const Text("Loading");
                return const Text("LOGIN");
              },
            ),
          )
        ],
      ),
    );
  }
}
